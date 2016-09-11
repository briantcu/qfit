class ProgressData

  attr_reader :x_axis_label, :y_axis_label, :dataset, :title, :has_data, :start_date, :end_date

  def initialize(x_label, y_label, data, title, has_data, start_date, end_date)
    @x_axis_label = x_label
    @y_axis_label = y_label
    @dataset = data
    @title = title
    @has_data = has_data
    @start_date = start_date
    @end_date = end_date
  end

end