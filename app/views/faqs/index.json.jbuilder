json.array!(@faqs) do |faq|
  json.extract! faq, :id, :question, :answer
end
