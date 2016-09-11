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
        proc = Proc.new {|r| {r.day_performed => r.weight} if r.weight.present? }
        title = 'Weight'
        label = 'Pounds'
      when 'power_index'
        proc = Proc.new {|r| {r.day_performed => r.power_index } if r.power_index.present? }
        title = 'PowerIndex'
        label = 'PowerIndex'
      when 'completed_workouts'
        proc = Proc.new {|r| {r.day_performed => (r.count_ex_completed / r.count_ex_provided)} rescue { r.day_performed => 0 }  }
        title = '% of Workouts Completed'
        label = '%'
      else 'exercise'
        proc = Proc.new {|r| {r.day_performed => r.performed_exercises.detect{ |ex| ex.id == @exercise.id}.try(:one_rep_max)} }
        title = '"#{@exercise.name} Estimated One Rep Max"'
        label = 'Pounds'
    end

    has_data = false
    (@start_date..Date.today).each do |date|
      r = @routines.detect {|r| r.day_performed == date}
      if r.present?
        obj = proc.call(r)
        if obj.present?
          has_data = true
          chart_data <<  obj
        else
          chart_data << { date => nil }
        end
      else
        chart_data << { date => nil }
      end
    end

    ProgressData.new('', label, chart_data, title, has_data, @start_date, Date.today)
  end

  private

  def get_routines
    @routines = @user.daily_routines.since(@start_date)
  end
end
