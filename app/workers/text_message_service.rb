class TextMessageService
  include Sidekiq::Worker
  require 'twilio-ruby'

  TWILIO_SID = "ACccd8a8c95f227f17d781c0fc9e1830f0"
  TWILIO_KEY = "6a36ac1ff1e0cb33529df395ad7f62c6"

  def perform(type, options = {})
    logger.info("TextService with type #{type} and options #{options}")
    case type
      when 'existing_user_pod_invite'
        send_existing_user_pod_invite(options)
      when 'new_user_pod_invite'
        send_new_user_pod_invite(options)
      when 'coach_invite'
        send_coach_sign_up_invite(options)
    end
  end

  def send_existing_user_pod_invite(options)
    invite = PodInvite.find(options['invite_id'])
    message = "#{invite.inviter.first_name} #{invite.inviter.last_name} has invited you to join their Quad Pod: https://www.quadfit.com/quad-pod"
    send_text(invite.invitee.phone, message)
  end

  def send_new_user_pod_invite(options)
    invite = PodInvite.find(options['invite_id'])
    token = options['token']
    message = "#{invite.inviter.first_name} #{invite.inviter.last_name} has invited you to join their Quad Pod on Quadfit. Sign up! https://www.quadfit.com/sign-up?pod_t=#{token}"
    send_text(invite.sent_to, message)
  end

  def send_coach_sign_up_invite(options)
    coach = User.find(options['user_id'])
    to = options['phone']
    message = "#{coach.first_name} #{coach.last_name} wants to be your coach on Quadfit. Sign up! https://www.quadfit.com/sign-up?qfcode=#{options['sign_up_code'].code}"
    send_text(to, message)
  end

  def send_text(to, message)
    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_KEY)
    client.account.messages.create(
        from: '6823052777',
        to: to,
        body: message
    )
  end
end