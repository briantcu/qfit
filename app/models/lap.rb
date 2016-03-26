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
  belongs_to :performed_sprint, dependent: :destroy

  scope :completed, -> {where(completed: true)}

  def self.create_lap(performed_sprint_id, lap_number)
    Lap.create(performed_sprint_id: performed_sprint_id, lap_number: lap_number)
  end
end
