class ProgressData

  attr_reader :x_axis_label, :y_axis_label, :dataset, :title

  def initialize(x_label, y_label, data, title)
    @x_axis_label = x_label
    @y_axis_label = y_label
    @dataset = data
    @title = title
  end

end