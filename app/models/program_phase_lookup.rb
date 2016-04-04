class ProgramPhaseLookup < ActiveRecord::Base
  belongs_to :phase

  def self.get_phase_id(phase_number, program_type)
      ProgramPhaseLookup.where(:phase_number => phase_number, :program_type => program_type).first.phase_id
  end
end
