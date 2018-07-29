class TextMessageService
  include Sidekiq::Worker
  require 'twilio-ruby'

  TWILIO_SID = ""
  TWILIO_KEY = ""

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
    message = "#{coach.first_name} #{coach.last_name} wants to be your coach on Quadfit. Sign up! https://www.quadfit.com/sign-up?qfcode=#{options['sign_up_code']}"
    send_text(to, message)
  end

  def send_text(to, message)
    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_KEY)
    client.api.account.messages.create(
        from: '',
        to: to,
        body: message
    )
  end
end