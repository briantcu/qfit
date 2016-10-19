json.array!(@plyometrics) do |plyometric|
  json.extract! plyometric, :id, :name, :video_link, :recommended, :paid_tier
end
