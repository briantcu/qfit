class SprintingService

  STRETCHING = 4
  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3

  @entity
  @routine

  def self.add_exercises(entity, routine)
    @entity = entity
    @routine = routine

    if @entity.sprint_diff > 5
      @entity.sprint_diff = 5
    end

    sprints = Sprint.where("difficulty <= ?", @entity.sprint_diff)
    num_sprints_for_index = sprints.size - 1
    index = rand(0..(num_sprints_for_index))
    sprint = sprints.at(index)
    @routine.add_sprint(sprint.id, 3, 0)
  end

  def self.copy_exercises(entity, routine, previous_routine)
    @entity = entity
    @routine = routine

    if previous_routine.changes_saved && previous_routine.sp_modified
      if entity.is_group
        previous_exercises = previous_routine.group_performed_sprints
      else
        previous_exercises = previous_routine.performed_sprints
      end
      @routine.note_sprint_changes_saved
    else
      previous_exercises = previous_routine.get_sprints_without_changes_saved
    end

    previous_exercises.each do |exercise|
      status = exercise.status
      #If changes were not saved, make invisible default exercises visible.
      if !previous_routine.changes_saved
        if status == 2
          status = 3
        end
      end
      @routine.add_sprint(exercise.id, status, 0) #0 = group performed exercise id
    end

    if previous_routine.changes_saved && previous_routine.sp_modified
      #copy custom exercises
      previous_routine.get_custom_exercises(SPRINTING).each do |exercise|
        @routine.add_custom_exercise(exercise.name, SPRINTING, 0)
      end
    end
  end
end