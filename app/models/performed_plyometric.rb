# == Schema Information
#
# Table name: performed_plyometrics
#
#  id                            :integer          not null, primary key
#  plyometric_id                 :integer
#  routine_id                    :integer
#  status                        :integer
#  group_performed_plyometric_id :integer
#  performed_one                 :boolean
#  performed_two                 :boolean
#  performed_three               :boolean
#  created_at                    :datetime
#  updated_at                    :datetime
#

class PerformedPlyometric < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :plyometric
  belongs_to :group_performed_plyo, :foreign_key => :group_performed_plyometric_id

  def self.add_exercise(exercise_id, status, routine_id, group_performed_ex_id)
    PerformedPlyometric.create(routine_id: routine_id, plyometric_id: exercise_id, status: status, group_performed_plyometric_id: group_performed_ex_id)
  end

  def as_json(options={})
    super(:include =>[:plyometric])
  end
end
