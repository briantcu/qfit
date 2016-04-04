class Phase < ActiveRecord::Base

  def self.get_set_info(program_type_id, phase_number)
    lookup = ProgramPhaseLookup.where(phase_number: phase_number, program_type: program_type_id).first
    Phase.find(lookup.phase_id)
  end
end
