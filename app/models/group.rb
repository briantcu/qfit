# == Schema Information
#
# Table name: groups
#
#  id                      :integer          not null, primary key
#  coach_user_id           :integer
#  name                    :string(255)
#  current_phase           :integer
#  sprint_diff             :integer
#  last_weight_day_created :integer
#  last_wu_day_created     :integer
#  last_pl_day_created     :integer
#  last_sp_day_created     :integer
#  shared                  :boolean
#  created_at              :datetime
#  updated_at              :datetime
#

class Group < ActiveRecord::Base
end
