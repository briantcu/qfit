require 'net/http'

Plyometric.all.order(created_at: :desc).each do |p|
  begin
    url = URI("https://api.vimeo.com/videos/" + p.video_link + "/pictures")
    request = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.request_uri)
    request.add_field 'Authorization', 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    request['Authorization'] = 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    res = http.request(request)

    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body['data'][0]['sizes'][3]['link'])
  rescue
    nil
  end

end

Exercise.all.order(created_at: :asc).each do |p|
  begin
    url = URI("https://api.vimeo.com/videos/" + p.video_link + "/pictures")
    request = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.request_uri)
    request.add_field 'Authorization', 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    request['Authorization'] = 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    res = http.request(request)
    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body['data'][0]['sizes'][3]['link'])
  rescue
    nil
  end
end


Warmup.all.each do |p|
  begin
    url = URI("https://api.vimeo.com/videos/" + p.video_link + "/pictures")
    request = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url.request_uri)
    request.add_field 'Authorization', 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    request['Authorization'] = 'Bearer 3dba7475594e5b75b941eae70e6f2c97'
    res = http.request(request)
    body = JSON.parse(res.body)
    p.update_attributes!(thumbnail: body['data'][0]['sizes'][3]['link'])
  rescue
    nil
  end
end