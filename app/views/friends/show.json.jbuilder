json.extract! @user, :id, :power_index, :user_name, :points, :bio
json.avatar @user.avatar_path
json.recent_workouts @recent_workouts do |workout|
  json.day_performed workout.day_performed
  json.share_link workout.share_link
end
json.is_friend @is_friend

