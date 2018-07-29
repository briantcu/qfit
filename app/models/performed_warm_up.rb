# == Schema Information
#
# Table name: performed_warm_ups
#
#  id              :integer          not null, primary key
#  routine_id      :integer
#  warmup_id       :integer
#  status          :integer
#  group_warmup_id :integer
#  completed       :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class PerformedWarmUp < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :warmup
  belongs_to :group_performed_warmup, :foreign_key => :group_warmup_id

  def self.add_exercise(exercise_id, status, routine_id, group_performed_ex_id)
    PerformedWarmUp.create(routine_id: routine_id, warmup_id: exercise_id, status: status, group_warmup_id: group_performed_ex_id)
  end

  def as_json(options={})
    super(:include =>[:warmup])
  end

  def sync_with_group(warmup_id)
    self.warmup_id = warmup_id
    self.save
  end

end
