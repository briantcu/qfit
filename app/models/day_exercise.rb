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
end
