# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  program_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Program < ActiveRecord::Base
end
