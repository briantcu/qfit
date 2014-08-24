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
        EmailService.send_new_sub_user_email_from_self_sign_up(user)
        EmailService.notify_coach_sub_signed_up(user, sign_up_code_record.user)
      end

    end
    user.save
    user
  end

  def self.register_user_for_coach(user, coach, temp_password)
    user.level = 1
    user.sub_user = true
    user.master_user_id = coach.id
    user.save
    EmailService.send_new_sub_user_email_from_coach(user, temp_password)
    user
  end

  def self.generate_password
    ('a'..'z').to_a.shuffle[0,8].join
  end
end