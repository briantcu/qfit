json.array!(@warmups) do |warmup|
  json.extract! warmup, :id, :name, :is_stretch, :video_link
  json.url warmup_url(warmup, format: :json)
end
