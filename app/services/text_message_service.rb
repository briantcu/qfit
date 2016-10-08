class TextMessageService
  include Sidekiq::Worker
  require 'clockwork'

  CLOCKWORK_KEY = "85108635f68cf5899770c869e9a68c9541717440"

  def perform(type, options = {})
    case type
      when :existing_user_pod_invite
        send_existing_user_pod_invite(options)
      when :new_user_pod_invite
        send_new_user_pod_invite(options)
      when :coach_invite
        send_coach_sign_up_invite(options)
    end
  end

  def send_existing_user_pod_invite(options)
    invite = PodInvite.find(options[:invite_id])
    message = "#{invite.inviter.first_name} #{invite.inviter.last_name} has invited you to join their Quad Pod: https://www.quadfit.com"
    send_text(invite.invitee.phone, message)
  end

  def send_new_user_pod_invite(options)
    invite = PodInvite.find(options[:invite_id])
    token = options[:token]
    message = "#{invite.inviter.first_name} #{invite.inviter.last_name} has invited you to join their Quad Pod on Quadfit. Sign up! https://www.quadfit.com?pod_t=#{token}"
    send_text(invite.sent_to, message)
  end

  def send_coach_sign_up_invite(options)
    coach = User.find(options[:user_id])
    to = options[:phone]
    message = "#{coach.first_name} #{coach.last_name} wants to be your coach on Quadfit. Sign up! https://www.quadfit.com?qfcode=#{options[:sign_up_code]}"
    send_text(to, message)
  end

  def send_text(to, message)
    api = Clockwork::API.new( CLOCKWORK_KEY )
    message = api.messages.build( to: to, content: message)
    response = message.deliver

    if response.success
      puts response.message_id
    else
      puts response.error_code
      puts response.error_description
    end
  end
end