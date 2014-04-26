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
end
