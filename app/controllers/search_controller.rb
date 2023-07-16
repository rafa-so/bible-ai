class SearchController < ApplicationController
  before_action :authenticate_user!

  ## GET /search/index
  def index
    conn = Faraday.new(
      url: ENV['BIBLIA_DIGITAL_BASE_URL'],
      headers: {'Content-Type' => 'application/json'}
    )

    result = conn.post("verses/search") do |req|
      req.headers["Authorization"] = "Bearer #{ENV['BIBLIA_DIGITAL_TOKEN']}"
      req.body = { version: 'nvi', search: params[:query] }.to_json
    end

    @response = JSON.parse(result.body).dig("verses")
  end
end
