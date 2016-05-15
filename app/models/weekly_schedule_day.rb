# == Schema Information
#
# Table name: weekly_schedule_days
#
#  id               :integer          not null, primary key
#  day              :integer
#  user_schedule_id :integer
#  weights          :boolean          default(FALSE)
#  plyometrics      :boolean          default(FALSE)
#  stretching       :boolean          default(FALSE)
#  sprinting        :boolean          default(FALSE)
#  created_at       :datetime
#  updated_at       :datetime
#

class WeeklyScheduleDay < ActiveRecord::Base
  belongs_to :user_schedule
end
