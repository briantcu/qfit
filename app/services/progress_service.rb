class ProgressService
  def initialize(user_id, chart_type, period, exercise_id)
    @user = User.find(user_id)
    @chart_type = chart_type
    @period = period
    @exercise = Exercise.find(exercise_id) if exercise_id.present?
    case @period
      when '1'
        @start_date = (Date.today - 3.months) > @user.daily_routines.oldest.day_performed ? (Date.today - 3.months) : @user.daily_routines.oldest.day_performed
      when '2'
        @start_date = (Date.today - 3.years) > @user.daily_routines.oldest.day_performed ? (Date.today - 3.years) : @user.daily_routines.oldest.day_performed
      when '3'
        @start_date = (Date.today - 1.year) > @user.daily_routines.oldest.day_performed ? (Date.today - 1.year) : @user.daily_routines.oldest.day_performed
      else
        @start_date = (Date.today - 1.month) > @user.daily_routines.oldest.day_performed ? (Date.today - 1.month) : @user.daily_routines.oldest.day_performed
    end
  end

  def get_chart
    get_routines

    chart_data = []
    case @chart_type
      when 'user_weight'
        proc = Proc.new {|r| {r.day_performed => r.weight} }
        title = 'Weight'
        label = 'Pounds'
      when 'power_index'
        proc = Proc.new {|r| {r.day_performed => r.power_index} }
        title = 'PowerIndex'
        label = 'PowerIndex'
      when 'completed_workouts'
        proc = Proc.new {|r| {r.day_performed => (r.count_ex_completed / r.count_ex_provided)} rescue nil  }
        title = '% of Workouts Completed'
        label = '%'
      else 'exercise'
        proc = Proc.new {|r| {r.day_performed => r.performed_exercises.detect{ |ex| ex.id == @exercise.id}.try(:one_rep_max)} }
        title = '"#{@exercise.name} Estimated One Rep Max"'
        label = 'Pounds'
    end

    (@start_date..Date.today).each do |date|
      r = @routines.detect {|r| r.day_performed == date}
      if r.present?
        chart_data << proc.call(r)
      else
        chart_data << { date => nil }
      end
    end

    ProgressData.new('', label, chart_data, title)
  end

  private

  def get_routines
    @routines = @user.daily_routines.since(@start_date)
  end
end
