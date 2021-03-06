# == Schema Information
#
# Table name: group_performed_plyos
#
#  id            :integer          not null, primary key
#  plyometric_id :integer
#  routine_id    :integer
#  status        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class GroupPerformedPlyo < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :plyometric

  def self.add_exercise(exercise_id, status, routine_id)
    GroupPerformedPlyo.create(routine_id: routine_id, plyometric_id: exercise_id, status: status)
  end

  def update_ex(params)
    if self.update(params)
      user_exes = get_user_exes
      user_exes.each do |user_ex|
        user_ex.sync_with_group(self.plyometric_id)
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
    PerformedPlyometric.where(group_performed_plyometric_id: self.id)
  end
end
