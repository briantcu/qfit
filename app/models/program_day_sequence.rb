# == Schema Information
#
# Table name: program_day_sequences
#
#  id             :integer          not null, primary key
#  program_id     :integer
#  number_of_days :integer
#  one            :integer
#  two            :integer
#  three          :integer
#  four           :integer
#  five           :integer
#  six            :integer
#  seven          :integer
#  eight          :integer
#  nine           :integer
#  ten            :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class ProgramDaySequence < ActiveRecord::Base
end
