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

  def get_next_day(current_day)

  end
end
