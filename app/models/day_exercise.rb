# == Schema Information
#
# Table name: day_exercises
#
#  id             :integer          not null, primary key
#  program_day_id :integer
#  ex_type        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class DayExercise < ActiveRecord::Base
  belongs_to :program_day

  def self.get_exercises_for_day(program_day_id)
    DayExercise.where(:program_day_id => program_day_id).order(id: :asc)
  end
end
