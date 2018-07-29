json.title @progress_data.title
json.y_axis_label @progress_data.y_axis_label
json.x_axis_label @progress_data.x_axis_label
json.has_data @progress_data.has_data
json.start_date @progress_data.start_date
json.end_date @progress_data.end_date
json.dataset @progress_data.dataset do |data|
  json.x data.keys[0]
  json.y data.values[0]
end