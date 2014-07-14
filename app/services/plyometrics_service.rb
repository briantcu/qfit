class PlyometricsService
  @entity
  @routine

  def self.add_exercises(entity, routine)
    @entity = entity
    @routine = routine


  end

  def self.copy_exercises(entity, routine, previous_routine)
    @entity = entity
    @routine = routine

  end
end

