class PerformedPlyometric < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id, dependent: :destroy
  belongs_to :plyometric
  belongs_to :group_performed_plyo, :foreign_key => :group_performed_plyometric_id

  def self.add_exercise(exercise_id, status, routine_id, group_performed_ex_id)
    PerformedPlyometric.create(routine_id: routine_id, plyometric_id: exercise_id, status: status, group_performed_plyometric_id: group_performed_ex_id)
  end

  def sync_with_group(plyo_id)
    self.plyometric_id = plyo_id
    self.save
  end

  def as_json(options={})
    super(:include =>[:plyometric])
  end
end
