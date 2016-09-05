json.title @progress_data.title
json.y_axis_label @progress_data.y_axis_label
json.x_axis_label @progress_data.x_axis_label
json.dataset @progress_data.dataset do |data|
  json.date data.keys[0]
  json.value data.values[0]
end