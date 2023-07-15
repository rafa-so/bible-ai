class SearchController < ApplicationController
  before_action :authenticate_user!

  ## GET /search/index
  def index
    content = ""
    result = HTTP.post("#{ENV['BIBLIA_DIGITAL_BASE_URL']}/verses/search",
      json: {
        version: "nvi",
        search: params[:query]
      }).body
    result.each { |chunk| content << chunk }

    @response = JSON.parse(content).dig("verses").map do | verse |
      {
        book_name: verse.dig("book", "name"),
        chapter: verse["chapter"],
        number: verse["number"],
        text: verse["text"]
      }
    end
  end
end
