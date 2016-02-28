# == Schema Information
#
# Table name: leaders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  first_name :string(255)
#  last_name  :string(255)
#  value      :string(255)
#  type       :integer
#  created    :date
#  created_at :datetime
#  updated_at :datetime
#

class Leader < ActiveRecord::Base
  MALE_POWER_INDEX = 1
  FEMALE_POWER_INDEX = 2
  MALE_POWER_INDEX_RATIO = 3
  FEMALE_POWER_INDEX_RATIO = 4
  SPRINTS_PERFORMED = 5
  PLYOS_PERFORMED = 6
  SETS_PERFORMED = 7
  REPS_PERFORMED = 8
end
