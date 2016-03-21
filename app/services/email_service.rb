class EmailService

  include Sidekiq::Worker
  def perform(type, options = {})
    case type
      when :new_user
        send_new_user_email(options)
      when :coach_sub_signed_up
        notify_coach_sub_signed_up(options)
      when :new_sub_email_from_coach
        send_new_sub_user_email_from_coach(options)
      when :new_sub_email_from_self
        send_new_sub_user_email_from_self_sign_up(options)
      when :new_coach
        send_new_coach_email(options)
      when :coach_deleted_you
        coach_deleted_you(options)
      when :existing_user_pod_invite
        send_existing_user_pod_invite(options)
      when :new_user_pod_invite
        send_new_user_pod_invite(options)
      when :coach_invite
        send_coach_sign_up_invite(options)
    end
  end

  def send_new_user_email(options)
    user = User.find(options[:user_id])
    Notifier.send_new_user_email(user).deliver
  end

  def notify_coach_sub_signed_up(options)
    coach = User.find(options[:coach_id])
    user = User.find(options[:user_id])
    Notifier.notify_coach_sub_signed_up(coach, user).deliver
  end

  def send_new_sub_user_email_from_coach(options)
    user = User.find(options[:user_id])
    password = options[:temp_password]
    Notifier.send_new_sub_user_email_from_coach(user, password).deliver
  end

  def send_new_sub_user_email_from_self_sign_up(options)
    user = User.find(options[:user_id])
    Notifier.send_new_sub_user_email_from_self_sign_up(user).deliver
  end

  def send_new_coach_email(options)
    user = User.find(options[:user_id])
    Notifier.send_new_coach_email(user).deliver
  end

  def coach_deleted_you(options)
    email = options[:email]
    Notifier.coach_deleted_you(email).deliver
  end

  def send_existing_user_pod_invite(options)
    invite = PodInvite.find(options[:invite_id])
    Notifier.send_existing_user_pod_invite(invite).deliver
  end

  def send_new_user_pod_invite(options)
    invite = PodInvite.find(options[:invite_id])
    token = options[:token]
    Notifier.send_new_user_pod_invite(invite, token).deliver
  end

  def send_coach_sign_up_invite(options)
    coach = User.find(options[:user_id])
    to = options[:phone]
    Notifier.send_coach_sign_up_invite(to, coach).deliver
  end
end