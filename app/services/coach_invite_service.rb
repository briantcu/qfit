class CoachInviteService

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

  def send_invite(to, coach_account)
    to.gsub!(/[^0-9]/, "") if to.validate(VALID_PHONE) #Strip all non numbers if it's a phone

    sent_code = SentCode.where(receiver: to, code: coach_account.user.sign_up_code)
    if sent_code.present?
      return { status: 'exists', message: 'An invite has already been sent', sent_code: sent_code}
    end

    if to.validate(VALID_EMAIL_REGEX)
      invitee = User.where(email: to).first
      if invitee.present?
        return { status: 'invalid', message: 'A user with that contact info already exists'}
      else
        sent_code = process_invite(to, coach_account, :email)
      end
    elsif to.validate(VALID_PHONE)
      invitee = User.where(phone: to).first
      if invitee.present?
        return { status: 'invalid', message: 'A user with that contact info already exists'}
      else
        sent_code = process_invite(to, coach_account, :phone)
      end
    else
      return { status: 'invalid', message: 'Please provide a valid email or phone number'}
    end

    { status: 'success', message: 'Success', sent_code: sent_code}
  end

  private

  def process_invite(to, coach_account, type)
    sent_code = SentCode.create(code: coach_account.user.sign_up_code, receiver: to, used: false)
    if type == :email
      EmailService.new.perform_async(:coach_invite, {user_id: coach_account.user.id, email: to})
    else
      TextMessageService.new.perform_async(:coach_invite, {user_id: coach_account.user.id, phone: to})
    end

    unless UserGoal.where(user_id: coach_account.user.id, goal_definition_id: 8).first.present?
      UserGoal.create!(user_id: coach_account.user.id, goal_definition_id: 8)
    end
    sent_code
  end
end