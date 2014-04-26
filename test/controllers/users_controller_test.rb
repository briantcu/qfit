require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { administrator: @user.administrator, birth_year: @user.birth_year, current_phase: @user.current_phase, email: @user.email, first_name: @user.first_name, hor_pull_max: @user.hor_pull_max, hor_push_max: @user.hor_push_max, knee_dom_max: @user.knee_dom_max, last_name: @user.last_name, last_plyometric_day_created: @user.last_plyometric_day_created, last_sprint_day_created: @user.last_sprint_day_created, last_warmup_day_created: @user.last_warmup_day_created, last_weight_day_created: @user.last_weight_day_created, level: @user.level, master_user_id: @user.master_user_id, password: @user.password, phone: @user.phone, power_index: @user.power_index, program_type: @user.program_type, sex: @user.sex, sprint_diff: @user.sprint_diff, sub_user: @user.sub_user, subscription_date: @user.subscription_date, user_name: @user.user_name, weight: @user.weight }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { administrator: @user.administrator, birth_year: @user.birth_year, current_phase: @user.current_phase, email: @user.email, first_name: @user.first_name, hor_pull_max: @user.hor_pull_max, hor_push_max: @user.hor_push_max, knee_dom_max: @user.knee_dom_max, last_name: @user.last_name, last_plyometric_day_created: @user.last_plyometric_day_created, last_sprint_day_created: @user.last_sprint_day_created, last_warmup_day_created: @user.last_warmup_day_created, last_weight_day_created: @user.last_weight_day_created, level: @user.level, master_user_id: @user.master_user_id, password: @user.password, phone: @user.phone, power_index: @user.power_index, program_type: @user.program_type, sex: @user.sex, sprint_diff: @user.sprint_diff, sub_user: @user.sub_user, subscription_date: @user.subscription_date, user_name: @user.user_name, weight: @user.weight }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
