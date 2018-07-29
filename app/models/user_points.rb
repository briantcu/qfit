# == Schema Information
#
# Table name: user_points
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  points     :integer
#  created_at :datetime
#  updated_at :datetime
#  diff       :integer
#

class UserPoints < ActiveRecord::Base
  belongs_to :user

  before_create :generate_diff

  def generate_diff
    last_entry = UserPoints.where(user_id: self.user_id).order(created_at: :desc).first
    if last_entry.present?
      self.diff = self.points - last_entry.points
    else
      self.diff = self.points
    end
  end
end
