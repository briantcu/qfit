require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  tests Users::RegistrationsController

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test 'should create regular user account passing in empty sign up code' do

    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', sign_up_code: '', account_type: 'user'})
    assert_response :created
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 2)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(!@controller.instance_variable_get(:@user).sub_user)
  end

  test 'should create regular user account without passing in sign up code' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    assert_response :created
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 2)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(!@controller.instance_variable_get(:@user).sub_user)
  end

  test 'should not create regular user with invalid email' do
    post(:create, user: { email: 'b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    assert_response 422
  end

  test 'should not create regular user with email that exists' do
    post(:create, user: { email: 'MyString6@a.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'user'})
    assert_response :created
  end

  test 'should not create user account with invalid sign up code' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', sign_up_code: 'code', account_type: 'user'})
    assert_response 470
  end

  test 'should create coach account' do
      post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                            first_name: 'brian', last_name: 'regan', account_type: 'coach'})
      assert_response :created
      assert(@controller.instance_variable_get(:@user).id != nil)
      assert(@controller.instance_variable_get(:@user).level == 5)
      assert(@controller.instance_variable_get(:@user).password == 'password')
      assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
      assert(!@controller.instance_variable_get(:@user).sub_user)
  end

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

  test 'should create sub user from coaches corner' do
    user = users(:one)
    sign_in user
    post(:create, user: { email: 'a@b.com', first_name: 'brian', last_name: 'regan'})
    assert_response :created
    assert(@controller.instance_variable_get(:@user).id != nil)
    assert(@controller.instance_variable_get(:@user).level == 1)
    assert(@controller.instance_variable_get(:@user).password == 'password')
    assert(@controller.instance_variable_get(:@user).encrypted_password != 'password')
    assert(@controller.instance_variable_get(:@user).sub_user)
    assert(@controller.instance_variable_get(:@user).master_user_id == 1)
  end

  test 'should not create sub user when coach is maxed out' do
    post(:create, user: { email: 'a@b.com', password: 'password', password_confirmation: 'password',
                          first_name: 'brian', last_name: 'regan', account_type: 'coach', sign_up_code: 'MyString2'})
    assert_response 471
  end

end