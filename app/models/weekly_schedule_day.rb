# == Schema Information
#
# Table name: weekly_schedule_days
#
#  id               :integer          not null, primary key
#  day              :integer
#  user_schedule_id :integer
#  weights          :boolean
#  plyometrics      :boolean
#  stretching       :boolean
#  sprinting        :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class WeeklyScheduleDay < ActiveRecord::Base
  attr_accessor :stretching, :weights, :plyometrics, :sprinting

  belongs_to :user_schedule

end
