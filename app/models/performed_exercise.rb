# == Schema Information
#
# Table name: performed_exercises
#
#  id                          :integer          not null, primary key
#  routine_id                  :integer
#  exercise_id                 :integer
#  rest_period                 :integer
#  status                      :integer
#  one_rep_max                 :integer
#  group_performed_exercise_id :integer
#  exercise_type_id            :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#

class PerformedExercise < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :group_performed_exercise
  belongs_to :exercise_type, :foreign_key => :exercise_type_id
  belongs_to :exercise, :foreign_key => :exercise_id
  has_many :weight_sets, -> { order('set_num ASC') }
  accepts_nested_attributes_for :weight_sets, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def self.add_exercise(exercise_id, status, routine_id, exercise_type, group_exercise_id)
    PerformedExercise.create(routine_id: routine_id, exercise_id: exercise_id, status: status, exercise_type_id: exercise_type, group_performed_exercise_id: group_exercise_id)
  end

  def as_json(options={})
    super(:include =>[:weight_sets, :exercise], :exclude => [:exercise_type])
  end

  def update_ex(params, need_to_create_sets)
    if self.update(params)
      if need_to_create_sets
        weight_set_service = WeightSetService.new(self.daily_routine.user, self.daily_routine, self)
        weight_set_service.create_sets
      end
      true
    else
      false
    end
  end

  def sync_with_group(exercise_id)
    self.exercise_id = exercise_id
    weight_set_service = WeightSetService.new(self.daily_routine.user, self.daily_routine, self)
    weight_set_service.create_sets
    self.save
  end

end
