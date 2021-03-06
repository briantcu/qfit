class QuadfitMailer < ApplicationMailer


  def send_new_user_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit", from: "\"Brian from Quadfit\" <bri@quadfit.com>")
  end

  def notify_coach_sub_signed_up(coach, user)
    @coach = coach
    @user = user
    mail(to: @coach.email, subject: "Your sign up code was used")
  end

  def send_new_sub_user_email_from_self_sign_up(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit", from: "\"Brian from Quadfit\" <bri@quadfit.com>")
  end

  def send_new_coach_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit", from: "\"Brian from Quadfit\" <bri@quadfit.com>")
  end

  def coach_deleted_you(email)
    @email = email
    mail(to: @email, subject: "Your Quadfit account has been deleted, but...")
  end

  def send_existing_user_pod_invite(invite)
    @inviter = invite.inviter
    @invitee = invite.invitee
    mail(to: @invitee.email, subject: "Quad Pod Invite from #{@inviter.first_name} #{@inviter_last_name}")
  end

  def send_new_user_pod_invite(invite, token)
    @inviter = invite.inviter
    @token = token
    mail(to: invite.sent_to, subject: "Quad Pod Invite from #{@inviter.first_name} #{@inviter_last_name}")
  end

  def send_coach_sign_up_invite(to, coach, code)
    @code = code
    subject = "#{coach.first_name} #{coach.last_name} wants to be your coach on Quadfit"
    mail(to: to, subject: subject)
  end

  def notify_coach_is_maxed(coach)
    subject = "Sign up failed - Your Quadfit account is maxed out"
    mail(to: coach.email, subject: subject)
  end

  def nightly_job(total_time, users, coaches)
    subject = "nightly job"
    @total_time = total_time
    @users = users
    @coaches = coaches
    mail(to: 'brian@quadfit.com', subject: subject)
  end

  def notify_payment_failed(user)
    @user = user
    mail(to:@user.email, subject: 'Quadfit payment failed')
  end

  def notify_someone_used_stripe
    mail(to: 'brian@quadfit.com', subject: 'Stripe checkout')
  end

  def notify_someone_used_apple
    mail(to: 'brian@quadfit.com', subject: 'Apple checkout')
  end
end
