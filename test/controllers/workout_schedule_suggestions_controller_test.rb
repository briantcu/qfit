require 'test_helper'

class WorkoutScheduleSuggestionsControllerTest < ActionController::TestCase
  setup do
    @workout_schedule_suggestion = workout_schedule_suggestions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_schedule_suggestions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout_schedule_suggestion" do
    assert_difference('WorkoutScheduleSuggestion.count') do
      post :create, workout_schedule_suggestion: { num_plyo_days: @workout_schedule_suggestion.num_plyo_days, num_sprint_days: @workout_schedule_suggestion.num_sprint_days, num_weight_days: @workout_schedule_suggestion.num_weight_days, program_id: @workout_schedule_suggestion.program_id, program_type: @workout_schedule_suggestion.program_type, weight_schedule: @workout_schedule_suggestion.weight_schedule }
    end

    assert_redirected_to workout_schedule_suggestion_path(assigns(:workout_schedule_suggestion))
  end

  test "should show workout_schedule_suggestion" do
    get :show, id: @workout_schedule_suggestion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workout_schedule_suggestion
    assert_response :success
  end

  test "should update workout_schedule_suggestion" do
    patch :update, id: @workout_schedule_suggestion, workout_schedule_suggestion: { num_plyo_days: @workout_schedule_suggestion.num_plyo_days, num_sprint_days: @workout_schedule_suggestion.num_sprint_days, num_weight_days: @workout_schedule_suggestion.num_weight_days, program_id: @workout_schedule_suggestion.program_id, program_type: @workout_schedule_suggestion.program_type, weight_schedule: @workout_schedule_suggestion.weight_schedule }
    assert_redirected_to workout_schedule_suggestion_path(assigns(:workout_schedule_suggestion))
  end

  test "should destroy workout_schedule_suggestion" do
    assert_difference('WorkoutScheduleSuggestion.count', -1) do
      delete :destroy, id: @workout_schedule_suggestion
    end

    assert_redirected_to workout_schedule_suggestions_path
  end
end
