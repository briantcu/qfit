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
end
