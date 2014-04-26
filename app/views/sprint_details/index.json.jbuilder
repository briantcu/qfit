json.array!(@sprint_details) do |sprint_detail|
  json.extract! sprint_detail, :id, :detail
  json.url sprint_detail_url(sprint_detail, format: :json)
end
