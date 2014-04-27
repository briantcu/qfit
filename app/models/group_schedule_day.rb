# == Schema Information
#
# Table name: group_schedule_days
#
#  id                :integer          not null, primary key
#  group_schedule_id :integer
#  weights           :boolean
#  plyos             :boolean
#  stretching        :boolean
#  sprinting         :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  day               :integer
#

class GroupScheduleDay < ActiveRecord::Base
  belongs_to :group_schedule
end
