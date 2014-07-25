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
  belongs_to :group_routine


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
    get_user_exes.each do |ex|
      ex.destroy
    end
    self.destroy
  end

  private

  def get_user_exes
    PerformedWarmUp.where(group_performed_warmups: self.id)
  end
end
