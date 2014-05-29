# == Schema Information
#
# Table name: group_schedules
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  program_id        :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  created_at        :datetime
#  updated_at        :datetime
#

class GroupSchedule < ActiveRecord::Base
  belongs_to :group
  has_many :group_schedule_days

  def is_valid_workout_day? (date)

  end

  def maintain_phases

  end

end
