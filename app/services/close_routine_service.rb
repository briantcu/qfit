class CloseRoutineService

  @routine

  def initialize(routine)
    @routine = routine
  end

  def close_routine
    #Mark as closed
    note_as_closed
    #update user weight
    update_user_weight
    #process user maxes
    process_user_maxes
    #process power index
    process_power_index
    #process completed/provided numbers
    process_completed_provided

    #@TODO
    #return encouraging message and next workout date

    @routine.save
  end

  private

  def note_as_closed

  end

  def update_user_weight

  end

  def process_user_maxes

  end

  def process_power_index

  end

  def process_completed_provided

  end

end