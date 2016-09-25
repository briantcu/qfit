require 'singleton'

class RegistrationService
  include Singleton

  def register_user(user, sign_up_code_record, account_type, session_service)
    User.transaction do
      #If not creating from admin, send welcome email and log them in
      if account_type == 'coach'
        #Coach
        user.assign_attributes(level: 5, sub_user: false)
        user.build_coach_account(billing_email: user.email, num_accts: 5)
        user.save!
        EmailService.perform_async(:new_coach, {user_id: user.id})
      else
        if sign_up_code_record.nil?
          #Regular user
          user.assign_attributes(level: 2, sub_user: false)
          if user.save!
            EmailService.perform_async(:new_user, {user_id: user.id})
          end
          session_service.set_viewing('user')
          session_service.set_setup_context('user')
        else
          #Sub user
          user.assign_attributes(level: 1, sub_user: true, master_user_id: sign_up_code_record.user_id)
          if user.save!
            EmailService.perform_async(:new_sub_email_from_self, {user_id: user.id})
            EmailService.perform_async(:coach_sub_signed_up, {user_id: user.id, coach_id: sign_up_code_record.user.id})
            sign_up_code_record.update_columns(used: true)
          end
          UserSchedule.create_user_schedule({user_id: user.id, program_type_id: 1, program_id: 1})
          session_service.set_viewing('user')
          session_service.set_setup_context('sub_user')
        end
      end
    end
    session_service.set_onboarding(true)
    user
  end
end