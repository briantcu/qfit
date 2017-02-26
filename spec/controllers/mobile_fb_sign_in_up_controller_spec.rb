require 'rails_helper'

RSpec.describe MobileFbSignInController, type: :controller do

  before(:each) do
    @controller = MobileFbSignInController.new
    @request.env['devise.mapping'] = Devise.mappings[:user]
    allow_any_instance_of(Gon::ControllerHelpers).to receive(:gon_request_uuid).and_return(6)
  end

  it 'should create a new user account' do
    post(:sign_in_up, email: 'a@b.com', uid: '124232', first_name: 'brian', last_name: 'regan', user_name: 'username', image: 'thisistheimage', gender: 'male')
    expect(response.status).to eq(200)
    @user = User.last
    expect(@user.id != nil).to be(true)
    expect(@user.level).to eq(2)
    expect(@user.provider).to eq('facebook')
    expect(@user.uid).to eq('124232')
    expect(@user.image).to eq('httpsistheimage?type=large')
    expect(@user.user_name).to eq('username')
    body = JSON.parse(response.body)
    expect(body['token']).to eq(@user.authentication_token)
  end

  it 'should log in an existing user' do
    user = FactoryGirl.create(:user, uid: '12367489', provider: 'facebook')
    post(:sign_in_up, email: 'a@b.com', uid: '12367489', first_name: 'brian', last_name: 'regan', user_name: 'username', image: 'thisistheimage', gender: 'male')
    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body['user_id']).to eq(user.id)
    expect(body['user_name']).to eq(user.user_name)
    expect(body['token']).to eq(user.authentication_token)
  end

  it 'should not create regular user with invalid email' do
    post(:sign_in_up, email: 'ab.com', uid: '12367489', first_name: 'brian', last_name: 'regan', user_name: 'username', image: 'thisistheimage', gender: 'male')
    expect(response.status).to eq(422)
  end
end