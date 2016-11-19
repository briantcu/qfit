class UserPointsService

  def self.record_monthly_points
    User.find_each do |user|
      UserPoints.create(user_id: user.id, points: user.points)
    end
  end
end