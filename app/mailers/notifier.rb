class Notifier < ActionMailer::Base

  default from: "web@quadfit.com"
  def send_new_user_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit!")
  end

  def notify_coach_sub_signed_up(coach, user)
    @coach = coach
    @user = user
    mail(to: @coach.email, subject: "Your sign up code was used")
  end

  def send_new_sub_user_email_from_coach(user, temp_password)
    @user = user
    @temp_password = temp_password
    mail(to: @user.email, subject: "You've been signed up for Quadfit!")
  end

  def send_new_sub_user_email_from_self_sign_up(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit!")
  end

  def send_new_coach_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Quadfit!")
  end

  def coach_deleted_you(email)
    @email = email
    mail(to: @email, subject: "Your Quadfit account has been deleted, but...")
  end
end