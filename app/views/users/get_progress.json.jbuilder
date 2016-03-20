json.title = @progress_data.title
json.y_axis_label = @progress_data.y_axis_label
json.array! @progress_data.dataset do |ds|
  json.date ds.key
  json.value ds.value
end