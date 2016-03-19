class UserPointsService

  def self.record_monthly_points
    User.all.each do |user|
      UserPoints.create(user_id: user.id, points: user.points)
    end
  end
end