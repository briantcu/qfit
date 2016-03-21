class QuadPodService

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_PHONE = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

  def send_invite(invite)
    invite.sent_to.gsub!(/[^0-9]/, "") if invite.sent_to.validate(VALID_PHONE) #Strip all non numbers if it's a phone

    pod_invite = PodInvite.where(inviter: current_user.id, sent_to: invite.sent_to).first
    if pod_invite.present?
      return { status: 'exists', message: 'A request has already been sent', pod_invite: pod_invite}
    end

    if invite.sent_to.validate(VALID_EMAIL_REGEX)
      pod_invite = process_invite(invite, :email)
    elsif invite.sent_to.validate(VALID_PHONE)
      pod_invite = process_invite(invite, :phone)
    else
      return { status: 'invalid', message: 'Please provide a valid email or phone number', pod_invite: invite}
    end

    { status: 'success', message: 'Success', pod_invite: pod_invite}
  end

  def accept_invite_new_user(token, user)
    # Would happen through sign up
    payload = JWT.decode token, Rails.application.config.token_salt, true, { :algorithm => 'HS256' }
    invite_data = payload[0]
    pod_invite = PodInvite.find(invite_data['id'])
    pod_invite.update_attributes!(invitee: user.user_id, status: 1)
    if invite_data['sent_to'].validate(VALID_PHONE)
      user.update_attributes!(phone: invite_data['sent_to'])
    end
    FriendService.new.make_friends(pod_invite.inviter, pod_invite.invitee)
  end

  def accept_invite_existing_user(invite)
    return unless invite.invitee == current_user.id && invite.status != 1 # Already accepted
    invite.status = 1
    invite.save!
    FriendService.new.make_friends(invite.inviter, invite.invitee)
  end

  def deny_invite(invite)
    return unless invite.invitee == current_user.id
    invite.status = 2
    invite.save!
  end

  private

  def process_invite(invite, type)
    if type == :email

      invitee = User.where(email: invite.sent_to).first
      if invitee.present?
        invite.invitee = invitee.id
        invite.save!
        EmailService.new.perform_async(:existing_user_pod_invite, {invite_id: invite.id})
      else
        invite.save!
        token = create_token(invite)
        EmailService.new.perform_async(:new_user_pod_invite, {invite_id: invite.id, token: token})
      end

    else

      invitee = User.where(phone: invite.sent_to).first
      if invitee.present?
        invite.invitee = invitee.id
        invite.save!
        TextMessageService.new.perform_async(:existing_user_pod_invite, {invite_id: invite.id})
      else
        invite.save!
        token = create_token(invite)
        TextMessageService.new.perform_async(:new_user_pod_invite, {invite_id: invite.id, token: token})
      end

    end

    unless UserGoal.where(user_id: invite.inviter, goal_definition_id: 6).first.present?
      UserGoal.create!(user_id: invite.inviter, goal_definition_id: 6)
      gd = GoalDefinition.find(6)
      inviter = User.find(invite.inviter.id)
      inviter.points += gd.points
      inviter.save
    end
  end

  def create_token(invite)
    payload = {sent_to: invite.sent_to, id: invite.id}
    JWT.encode payload, Rails.application.config.token_salt, 'HS256'
  end
end