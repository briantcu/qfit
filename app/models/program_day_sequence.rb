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

# ProgramDaySequence_1:
#     id: 1
# program_id: 1   FULL
# number_of_days: 2
# one: 1
# two: 2
# three: 0
# four: 0
# five: 0
# six: 0
# seven: 0
# eight: 0
# nine: 0
# ten: 0
# ProgramDaySequence_2:
#     id: 2
# program_id: 2  HALF
# number_of_days: 4
# one: 3
# two: 4
# three: 5
# four: 6
# five: 0
# six: 0
# seven: 0
# eight: 0
# nine: 0
# ten: 0
# ProgramDaySequence_3:
#     id: 3
# program_id: 3   3 DAY MIXED
# number_of_days: 6
# one: 3
# two: 2
# three: 4
# four: 5
# five: 1
# six: 6
# seven: 0
# eight: 0
# nine: 0
# ten: 0
# ProgramDaySequence_4:
#     id: 4
# program_id: 4    4 DAY MIXED
# number_of_days: 8
# one: 3
# two: 2
# three: 4
# four: 1
# five: 5
# six: 2
# seven: 6
# eight: 1
# nine: 0
# ten: 0
# ProgramDaySequence_5:
#     id: 5
# program_id: 5   T4P
# number_of_days: 4
# one: 7
# two: 8
# three: 9
# four: 10
# five: 0
# six: 0
# seven: 0
# eight: 0
# nine: 0
# ten: 0


class ProgramDaySequence < ActiveRecord::Base
  belongs_to :program
  belongs_to :program_day, :foreign_key => :one
  belongs_to :program_day, :foreign_key => :two
  belongs_to :program_day, :foreign_key => :three
  belongs_to :program_day, :foreign_key => :four
  belongs_to :program_day, :foreign_key => :five
  belongs_to :program_day, :foreign_key => :six
  belongs_to :program_day, :foreign_key => :seven
  belongs_to :program_day, :foreign_key => :eight
  belongs_to :program_day, :foreign_key => :nine
  belongs_to :program_day, :foreign_key => :ten

  def self.get_program_day_id(index, program_id)
    program_day_sequence = ProgramDaySequence.where(:program_id => program_id).first
    program_day_id = 1
    case index
      when 1
        program_day_id = program_day_sequence.one
      when 2
        program_day_id = program_day_sequence.two
      when 3
        program_day_id = program_day_sequence.three
      when 4
        program_day_id = program_day_sequence.four
      when 5
        program_day_id = program_day_sequence.five
      when 6
        program_day_id = program_day_sequence.six
      when 7
        program_day_id = program_day_sequence.seven
      when 8
        program_day_id = program_day_sequence.eight
      when 9
        program_day_id = program_day_sequence.nine
      when 10
        program_day_id = program_day_sequence.ten
    end

    program_day_id
  end

  def self.get_total_days(program_id)
    program_day_sequence = ProgramDaySequence.where(:program_id => program_id).first
    program_day_sequence.number_of_days
  end
end
