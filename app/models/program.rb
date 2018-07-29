# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  program_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# ---
# Program_1:
#     id: 1
# program_name: Full
# Program_2:
#     id: 2
# program_name: Half
# Program_3:
#     id: 3
# program_name: 3 Day Mixed
# Program_4:
#     id: 4
# program_name: 4 Day Mixed
# Program_5:
#     id: 5
# program_name: T4P

class Program < ActiveRecord::Base
  has_one :program_day_sequence
end
