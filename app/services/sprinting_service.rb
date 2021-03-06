require 'singleton'

class SprintingService
  include Singleton

  WEIGHTS = 1
  PLYOS = 2
  SPRINTING = 3
  STRETCHING = 4

  DELETED = 2
  VISIBLE = 3

  @entity
  @routine

  def add_exercises(entity, routine)
    @entity = entity
    @routine = routine

    if @entity.sprint_diff.to_i > 5
      @entity.sprint_diff = 5
      @entity.save!
    end

    sprints = Sprint.where("difficulty <= ?", @entity.sprint_diff.to_i)
    num_sprints_for_index = sprints.count - 1
    index = rand(0..(num_sprints_for_index))
    sprint = sprints.at(index)
    @routine.add_sprint(sprint.id, 3, 0)
  end

  def copy_exercises(entity, routine, previous_routine)
    @entity = entity
    @routine = routine

    if previous_routine.changes_saved && previous_routine.sp_modified
      if entity.is_group?
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
      unless previous_routine.changes_saved
        if status == 2
          status = 3
        end
      end
      @routine.add_sprint(exercise.sprint_id, status, 0) #0 = group performed exercise id
    end

    if previous_routine.changes_saved && previous_routine.sp_modified
      #copy custom exercises
      previous_routine.get_custom_exercises(SPRINTING).each do |exercise|
        @routine.add_custom_exercise(exercise.name, SPRINTING, 0)
      end
    end
  end
end