json.array!(@plyometrics) do |plyometric|
  json.extract! plyometric, :id, :name, :video_link, :recommended
end
