# == Schema Information
#
# Table name: program_phase_lookups
#
#  id           :integer          not null, primary key
#  phase_number :integer
#  program_type :integer
#  phase_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ProgramPhaseLookup < ActiveRecord::Base
  belongs_to :phase

  def self.get_phase_id(phase_number, program_type)
      ProgramPhaseLookup.where(:phase_number => phase_number, :program_type => program_type).first.phase_id
  end
end
