module SearchHelper
  def sanitize_response(response)
    obj = OpenStruct.new(response)
    "#{obj.book_name} #{obj.chapter}.#{obj.number} - #{obj.text}"
  end
end
