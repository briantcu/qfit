# == Schema Information
#
# Table name: program_types
#
#  id           :integer          not null, primary key
#  program_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

#(1,'PowerLean'),(2,'PowerMass'),(3,'PowerRip');
class ProgramType < ActiveRecord::Base
end
