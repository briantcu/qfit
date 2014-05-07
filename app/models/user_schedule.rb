# == Schema Information
#
# Table name: user_schedules
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  program_id        :integer
#  program_type_id   :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  sign_up_date      :date
#  created_at        :datetime
#  updated_at        :datetime
#

class UserSchedule < ActiveRecord::Base
  belongs_to :user
  has_many :weekly_schedule_days
  belongs_to :program_type
  belongs_to :program
  accepts_nested_attributes_for :weekly_schedule_days, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }
  validates_presence_of :user_id, :program_id, :program_type_id, :phase_one_start, :phase_two_start, :phase_three_start,
                        :phase_four_start, :sign_up_date

  def setup_phases
    now = Date.current
    self.phase_one_start = now
    self.phase_two_start = now.advance(:weeks => 3)
    self.phase_three_start = self.phase_two_start.advance(:weeks => 3)
    self.phase_four_start = self.phase_three_start.advance(:weeks => 3)
  end
end
