class RegistrationService
  def self.register_user(user, sign_up_code_record, account_type)
    #If not creating from admin, send welcome email and log them in
    if account_type == 'coach'
      #Coach
      user.level = 5
      user.sub_user = false
      EmailService.send_new_coach_email(user)
    else
      if sign_up_code_record.nil?
        #Regular user
        user.level = 2
        user.sub_user = false
        EmailService.send_new_user_email(user)
      else
        #Sub user
        user.level = 1
        user.sub_user = true
        user.master_user_id = sign_up_code_record.user.id
        EmailService.send_new_sub_user_email(user, temp_password)
        EmailService.notify_coach_sub_signed_up(user, coach)
      end

    end
    user.save
  end

  def self.register_user_for_coach(user, coach)
    user.level = 1
    user.sub_user = true
    user.master_user_id = coach.id
    temp_password = generate_password
    user.password = temp_password
    user.save
    EmailService.send_new_sub_user_email(user, temp_password)
  end

  private

  def self.generate_password
    ('a'..'z').to_a.shuffle[0,8].join
  end
end