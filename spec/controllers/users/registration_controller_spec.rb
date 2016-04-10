=begin
test 'should create sub user and tie to existing coach' do
  post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                        first_name: 'brian', last_name: 'regan', account_type: 'user', sign_up_code: 'MyString'})
  assert_response :created
  assert(@controller.instance_variable_get(:@user).id != nil)
  assert(@controller.instance_variable_get(:@user).level == 1)
  assert(@controller.instance_variable_get(:@user).password == 'password')
  assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
  assert(@controller.instance_variable_get(:@user).sub_user)
  assert(@controller.instance_variable_get(:@user).master_user_id == 1)
end

test 'should make friend if signing up with a quad pod invite token' do
  invite = PodInvite.create!(inviter: User.last, sent_to: '8172913409')
  payload = {sent_to: invite.sent_to, id: invite.id}
  token = JWT.encode payload, Rails.application.config.token_salt, 'HS256'
  post(:create, user: {
      email: 'a@b.com', password: 'password', password_confirmation: 'password', first_name: 'brian',
      last_name: 'regan', account_type: 'user', sign_up_code: 'MyString'}, invite_token: token)
  assert_response :created
  assert(@controller.instance_variable_get(:@user).friends.count == 1)
  assert(@controller.instance_variable_get(:@user).phone == '8172913409')
end=end
