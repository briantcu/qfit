require 'net/http'

Plyometric.all.each do |p|
  begin
    url = URI("http://vimeo.com/api/v2/video/" + p.video_link + ".json")
    res = Net::HTTP.get_response(url)
    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body[0]['thumbnail_medium'])
  rescue
    nil
  end

end

Exercise.all.each do |p|
  begin
    url = URI("http://vimeo.com/api/v2/video/" + p.video_link + ".json")
    res = Net::HTTP.get_response(url)
    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body[0]['thumbnail_medium'])
  rescue
    nil
  end
end


Warmup.all.each do |p|
  begin
    url = URI("http://vimeo.com/api/v2/video/" + p.video_link + ".json")
    res = Net::HTTP.get_response(url)
    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body[0]['thumbnail_medium'])
  rescue
    nil
  end
end