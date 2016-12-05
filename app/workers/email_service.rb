class EmailService

  include Sidekiq::Worker

  def perform(type, options = {})
    logger.info("EmailService with type #{type} and options #{options}")
    case type
      when 'new_user'
        send_new_user_email(options)
      when 'coach_sub_signed_up'
        notify_coach_sub_signed_up(options)
      when 'new_sub_email_from_self'
        send_new_sub_user_email_from_self_sign_up(options)
      when 'new_coach'
        send_new_coach_email(options)
      when 'coach_deleted_you'
        coach_deleted_you(options)
      when 'existing_user_pod_invite'
        send_existing_user_pod_invite(options)
      when 'new_user_pod_invite'
        send_new_user_pod_invite(options)
      when 'coach_invite'
        send_coach_sign_up_invite(options)
      when 'coach_maxed'
        notify_coach_is_maxed(options)
      when 'payment_failed'
        notify_payment_failed(options)
      when 'billing_happened'
        notify_someone_used_stripe
    end
  end

  def send_new_user_email(options)
    user = User.find(options['user_id'])
    QuadfitMailer.send_new_user_email(user).deliver_now
  end

  def notify_coach_sub_signed_up(options)
    coach = User.find(options['coach_id'])
    user = User.find(options['user_id'])
    QuadfitMailer.notify_coach_sub_signed_up(coach, user).deliver_now
  end

  def send_new_sub_user_email_from_self_sign_up(options)
    user = User.find(options['user_id'])
    QuadfitMailer.send_new_sub_user_email_from_self_sign_up(user).deliver_now
  end

  def send_new_coach_email(options)
    user = User.find(options['user_id'])
    QuadfitMailer.send_new_coach_email(user).deliver_now
  end

  def coach_deleted_you(options)
    email = options['email']
    QuadfitMailer.coach_deleted_you(email).deliver_now
  end

  def send_existing_user_pod_invite(options)
    invite = PodInvite.find(options['invite_id'])
    QuadfitMailer.send_existing_user_pod_invite(invite).deliver_now
  end

  def send_new_user_pod_invite(options)
    invite = PodInvite.find(options['invite_id'])
    token = options['token']
    QuadfitMailer.send_new_user_pod_invite(invite, token).deliver_now
  end

  def send_coach_sign_up_invite(options)
    coach = User.find(options['user_id'])
    to = options['email']
    code = options['sign_up_code']
    QuadfitMailer.send_coach_sign_up_invite(to, coach, code).deliver_now
  end

  def notify_coach_is_maxed(options)
    coach = User.find(options['user_id'])
    QuadfitMailer.notify_coach_is_maxed(coach).deliver_now
  end

  def notify_payment_failed(options)
    user = User.find(options['user_id'])
    QuadfitMailer.notify_payment_failed(user).deliver_now
  end

  def notify_someone_used_stripe
    QuadfitMailer.notify_someone_used_stripe
  end
end