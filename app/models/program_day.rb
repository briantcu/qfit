# == Schema Information
#
# Table name: program_days
#
#  id              :integer          not null, primary key
#  day_enumeration :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class ProgramDay < ActiveRecord::Base
end
