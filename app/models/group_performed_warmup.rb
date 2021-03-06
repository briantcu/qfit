# == Schema Information
#
# Table name: group_performed_warmups
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  warmup_id  :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedWarmup < ActiveRecord::Base
  belongs_to :group_routine, foreign_key: :routine_id
  belongs_to :warmup

  def self.add_exercise(exercise_id, status, routine_id)
      GroupPerformedWarmup.create(routine_id: routine_id, warmup_id: exercise_id, status: status)
  end

  def update_ex(params)
    if self.update(params)
      exes = get_user_exes
      exes.each do |ex|
        ex.sync_with_group(self.warmup_id)
      end
      true
    else
      false
    end
  end

  def destroy_ex
    if status == 1
      get_user_exes.each do |ex|
        ex.destroy
      end
      self.destroy
    else
      get_user_exes.each do |ex|
        ex.status = 2
        ex.save
      end
      self.status = 2
      self.save
    end
  end

  private

  def get_user_exes
    PerformedWarmUp.where(group_warmup_id: self.id)
  end
end
