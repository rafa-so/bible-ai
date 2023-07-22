module SearchHelper
  def reference(response)
    book = response.dig('book', 'name')
    reference = "#{book} #{response["chapter"]}.#{response["number"]}"
  end

  def content(response)
    response["text"]
  end
end
