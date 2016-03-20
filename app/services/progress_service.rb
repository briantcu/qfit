class ProgressService
  def initialize(user_id, chart_type, period, exercise_id)
    @user = User.find(user_id)
    @chart_type = chart_type
    @period = period
    @exercise = Exercise.find(exercise_id)
  end

  def get_chart
    get_routines

    case @chart_type
      when 'user_weight'
        data = @routines.map {|r| {r.day_performed => r.weight}}
        return ProgressData.new(x_axis_label: '', y_axis_label: 'Pounds', dataset: data, title: 'Weight')
      when 'power_index'
        data = @routines.map {|r| {r.day_performed => r.power_index}}
        return ProgressData.new(x_axis_label: '', y_axis_label: 'PowerIndex', dataset: data, title: 'PowerIndex')
      when 'completed_workouts'
        data = @routines.map {|r| {r.day_performed => (r.count_ex_completed / r.count_ex_provided)}}
        return ProgressData.new(x_axis_label: '', y_axis_label: '%', dataset: data, title: '% of Workouts Completed')
      else 'exercise'
        data = @routines.map {|r| {r.day_performed => r.performed_exercises.find{ |ex| ex.id == @exercise.id}.try(:one_rep_max)}}
        return ProgressData.new(x_axis_label: '', y_axis_label: 'Pounds', dataset: data, title: "#{@exercise.name} Estimated One Rep Max")
    end

  end

  private

  def get_routines
    case @period
      when 1
        @routines = @user.daily_routines.closed_since(Date.today - 3.months)
      when 2
        @routines = @user.daily_routines.closed_since(Date.today - 6.months)
      when 3
        @routines = @user.daily_routines.closed_since(Date.today - 1.year)
      else
        @routines = @user.daily_routines.closed_since(Date.today - 1.month)
    end
  end

  def user_weight_data
    DailyRoutine.closed_since(@last_date)
  end

end