class ProgressService
  def initialize(user_id, chart_type, period, exercise_id)
    @user_id = user_id
    @chart_type = chart_type
    @period = period
    @exercise_id = exercise_id
  end

  def get_chart
    determine_date_range
  end

  private

  def determine_date_range
    case @period
      when 1
        @last_date = Date.today - 3.months
      when 2
        @last_date = Date.today - 6.months
      when 3
        @last_date = Date.today - 1.year
      else
        @last_date = Date.today - 1.month
    end
  end


end