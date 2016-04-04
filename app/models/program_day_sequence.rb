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
