json.array!(@plyometrics) do |plyometric|
  json.extract! plyometric, :id, :name, :video_link, :recommended
  json.url plyometric_url(plyometric, format: :json)
end
