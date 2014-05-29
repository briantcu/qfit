# == Schema Information
#
# Table name: phases
#
#  id              :integer          not null, primary key
#  male_power_sets :integer
#  male_power_reps :integer
#  male_other_sets :integer
#  male_other_reps :integer
#  fem_power_sets  :integer
#  fem_power_reps  :integer
#  fem_other_sets  :integer
#  fem_other_reps  :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Phase < ActiveRecord::Base

  def self.get_set_info(program_type_id, phase_number)
    lookup = ProgramPhaseLookup.where(phase_number: phase_number, program_type: program_type_id).first
    Phase.find(lookup.phase_id)
  end
end
