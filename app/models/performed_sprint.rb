class PerformedSprint < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id, dependent: :destroy
  belongs_to :sprint
  belongs_to :group_performed_sprint, :foreign_key => :group_performed_sprint_id
  has_many :laps, -> { order('id ASC') }
  accepts_nested_attributes_for :laps, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def self.add_exercise(exercise_id, status, routine_id, group_performed_ex_id)
    PerformedSprint.create(routine_id: routine_id, sprint_id: exercise_id, status: status, group_performed_sprint_id: group_performed_ex_id)
  end

  def update_ex(params, need_to_create_laps)
    if self.update(params)
      if need_to_create_laps
        self.laps.each do |lap|
          lap.destroy
        end
        self.laps = []
        num_laps = self.sprint.num_laps
        for i in 1..num_laps
          self.laps << Lap.create_lap(self.id, i)
        end
      end
      true
    else
      false
    end
  end

  def sync_with_group(sprint_id, need_to_create_laps)
    self.sprint_id = sprint_id
    self.laps.each do |lap|
      lap.destroy
    end
    self.laps = []

    num_laps = self.sprint.num_laps
    for i in 1..num_laps
      self.laps << Lap.create_lap(self.id, i)
    end
    self.save
  end

  def as_json(options={})
    super(:include =>[:laps, :sprint])
  end
end
