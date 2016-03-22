class RegistrationService
  def self.register_user(user, sign_up_code_record, account_type)
    #If not creating from admin, send welcome email and log them in
    if account_type == 'coach'
      #Coach
      user.level = 5
      user.sub_user = false
      user.build_coach_account(billing_email: user.email, num_accounts: 5)
      user.save!
      EmailService.perform_async(:new_coach, {user_id: user.id})
    else
      if sign_up_code_record.nil?
        #Regular user
        user.level = 2
        user.sub_user = false
        user.save!
        EmailService.perform_async(:new_user, {user_id: user.id})
      else
        #Sub user
        user.level = 1
        user.sub_user = true
        user.master_user_id = sign_up_code_record.user.id
        user.save!
        EmailService.perform_async(:new_sub_email_from_self, {user_id: user.id})
        EmailService.perform_async(:coach_sub_signed_up, {user_id: user.id, coach_id: sign_up_code_record.user.id})
      end
    end
    user
  end

  def self.register_user_for_coach(user, coach, temp_password)
    user.level = 1
    user.sub_user = true
    user.master_user_id = coach.id
    user.save!
    EmailService.perform_async(:new_sub_email_from_coach, {user_id: user.id, temp_password: temp_password})
    user
  end

  def self.generate_password
    ('a'..'z').to_a.shuffle[0,8].join
  end
end