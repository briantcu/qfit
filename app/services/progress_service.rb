class ProgressService
  def initialize(user_id, chart_type, period, exercise_id)
    @user = User.find(user_id)
    @chart_type = chart_type
    @period = period
    @exercise = Exercise.find(exercise_id) if exercise_id.present?
  end

  def get_chart
    get_routines

    #@TODO do nil checks on values below
    case @chart_type
      when 'user_weight'
        data = @routines.map {|r| {r.day_performed => r.weight} if r.weight.present?}
        data.delete_if {|d| d.blank? || d.values[0].nil?}
        return ProgressData.new('', 'Pounds', data, 'Weight')
      when 'power_index'
        data = @routines.map {|r| {r.day_performed => r.power_index} if r.power_index.present? }
        data.delete_if {|d| d.blank? || d.values[0].nil?}
        return ProgressData.new('', 'PowerIndex', data, 'PowerIndex')
      when 'completed_workouts'
        data = @routines.map {|r| {r.day_performed => (r.count_ex_completed / r.count_ex_provided)} rescue nil }
        data.delete_if {|d| d.blank? || d.values[0].nil?}
        return ProgressData.new('', '%', data, '% of Workouts Completed')
      else 'exercise'
        data = @routines.map {|r| {r.day_performed => r.performed_exercises.detect{ |ex| ex.id == @exercise.id}.try(:one_rep_max)}}
        data.delete_if {|d| d.blank? || d.values[0].nil?}
        return ProgressData.new('', 'Pounds', data, "#{@exercise.name} Estimated One Rep Max")
    end

  end

  private

  def get_routines
    case @period
      when 1
        @routines = @user.daily_routines.since(Date.today - 3.months)
      when 2
        @routines = @user.daily_routines
      when 3
        @routines = @user.daily_routines.since(Date.today - 1.year)
      else
        @routines = @user.daily_routines.since(Date.today - 1.month)
    end
  end
end
