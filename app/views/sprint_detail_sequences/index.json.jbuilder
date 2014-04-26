json.array!(@sprint_detail_sequences) do |sprint_detail_sequence|
  json.extract! sprint_detail_sequence, :id, :sprint_id, :detail_num, :order_num
  json.url sprint_detail_sequence_url(sprint_detail_sequence, format: :json)
end
