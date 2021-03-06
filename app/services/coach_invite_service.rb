require 'singleton'
class CoachInviteService
  include Singleton

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

  def send_invite(to, coach_account, sign_up_type, template_id, program_type_id = nil)
    to.gsub!(/[^0-9]/, "") if VALID_PHONE.match(to) #Strip all non numbers if it's a phone

    sent_code = SignUpCode.where(sent_to: to, user_id: coach_account.user.id).first
    if sent_code.present?
      return { status: 'exists', message: 'An invite has already been sent', sent_code: sent_code}
    end

    if VALID_EMAIL_REGEX.match(to)
      invitee = User.where(email: to).first
      if invitee.present?
        return { status: 'invalid', message: 'A user with that contact info already exists'}
      else
        sent_code = process_invite(to, coach_account, :email, sign_up_type, template_id, program_type_id)
      end
    elsif VALID_PHONE.match(to)
      invitee = User.where(phone: to).first
      if invitee.present?
        return { status: 'invalid', message: 'A user with that contact info already exists'}
      else
        sent_code = process_invite(to, coach_account, :phone, sign_up_type, template_id, program_type_id)
      end
    else
      return { status: 'invalid', message: 'Please provide a valid email or phone number'}
    end

    { status: 'success', message: 'Success', sent_code: sent_code}
  end

  private

  def process_invite(to, coach_account, type, sign_up_type, template_id, program_type_id)
    code = SignUpCode.unique_code
    sent_code = SignUpCode.create(
        code: code,
        sent_to: to,
        sent_to_type: type,
        sign_up_type: sign_up_type,
        group_id: template_id,
        user_id: coach_account.user_id,
        program_type_id: program_type_id
    )

    if type == :email
      EmailService.perform_async(:coach_invite, {user_id: coach_account.user.id, email: to, sign_up_code: sent_code.code})
    else
      TextMessageService.perform_async(:coach_invite, {user_id: coach_account.user.id, phone: to, sign_up_code: sent_code.code})
    end

    unless UserGoal.where(user_id: coach_account.user.id, goal_definition_id: 8).first.present?
      UserGoal.create!(user_id: coach_account.user.id, goal_definition_id: 8)
    end
    sent_code
  end
end