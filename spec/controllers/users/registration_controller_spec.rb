require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do

  before(:each) do
    @controller = Users::RegistrationsController.new
    @request.env['devise.mapping'] = Devise.mappings[:user]
    allow_any_instance_of(Gon::ControllerHelpers).to receive(:gon_request_uuid).and_return(6)
    @coach = FactoryGirl.create(:user, level: 5)
    @coach_account = FactoryGirl.create(:coach_account, user: @coach)
    FactoryGirl.create(:sign_up_code, user: @coach, code: 'MyString')
  end

  it 'should create sub user and tie to existing coach' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user', sign_up_code: 'MyString'})
    expect(response.status).to eq(201)
    expect(@controller.instance_variable_get(:@user).id != nil).to be(true)
    expect(@controller.instance_variable_get(:@user).level).to eq(1)
    expect(@controller.instance_variable_get(:@user).password).to eq('password')
    expect(@controller.instance_variable_get(:@user).encrypted_password != 'password').to be(true)
    expect(@controller.instance_variable_get(:@user).sub_user).to be(true)
    expect(@controller.instance_variable_get(:@user).master_user_id).to eq(@coach.id)
  end

  it 'should make friend if signing up with a quad pod invite token' do
    invite = PodInvite.create!(inviter: User.last, sent_to: '8172913409')
    payload = {sent_to: invite.sent_to, id: invite.id}
    token = JWT.encode payload, Rails.application.config.token_salt, 'HS256'
    session[:invite_token] = token
    post(:create, user: {
        email: 'a@b.com', password: 'password', password_confirmation: 'password', first_name: 'brian',
        last_name: 'regan', account_type: 'user', sign_up_code: 'MyString'})
    expect(response.status).to eq(201)
    expect(@controller.instance_variable_get(:@user).friends.count == 1).to be true
    expect(@controller.instance_variable_get(:@user).phone == '8172913409').to be true
  end

  it 'should create regular user account passing in empty sign up code' do

    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', sign_up_code: '', account_type: 'user'})
    expect(response.status).to eq(201)
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 2)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(!@controller.instance_variable_get(:@user).sub_user)
  end

  it 'should create regular user account without passing in sign up code' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    assert_response :created
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 2)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(!@controller.instance_variable_get(:@user).sub_user)
  end

  it 'should not create regular user with invalid email' do
    post(:create, user: { email: 'b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    expect(response.status).to eq(422)
  end

  it 'should not create regular user with email that exists' do
    post(:create, user: { email: 'MyString6@a.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    expect(response.status).to eq(201)
  end

  it 'should not create user account with invalid sign up code' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', sign_up_code: 'code', account_type: 'user'})
    expect(response.status).to eq(470)
  end

  it 'should create coach account' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'coach'})
    expect(response.status).to eq(201)
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 5)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(!@controller.instance_variable_get(:@user).sub_user)
  end

end