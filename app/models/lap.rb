# == Schema Information
#
# Table name: laps
#
#  id                  :integer          not null, primary key
#  lap_number          :integer
#  performed_sprint_id :integer
#  completed           :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

class Lap < ActiveRecord::Base
  belongs_to :performed_sprint
end
