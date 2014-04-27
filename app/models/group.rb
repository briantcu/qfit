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
  belongs_to :user, :foreign_key => :coach_user_id
  has_many :users, :through => :group_joins
  has_one :group_schedule
end
