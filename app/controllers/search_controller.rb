class SearchController < ApplicationController
  before_action :authenticate_user!

  ## GET /search/index
  def index
    conn = Faraday.new(
      url: ENV['BIBLIA_DIGITAL_BASE_URL'],
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{ENV['BIBLIA_DIGITAL_TOKEN']}"
      }
    )

    payload = { version: 'nvi', search: params[:query] }
    result = conn.post("verses/search"){ |req| req.body = payload.to_json }
    @response = { verses: JSON.parse(result.body).dig("verses"), term: params[:query] }

    create_search if has_result?
  rescue Faraday::Error => e
    puts e.response[:status]
    puts e.response[:body]
  end

  private

  def has_result?
    @response[:verses].present?
  end

  def create_search
    Search.create!(user: current_user, term: @response[:term], content: @response[:verses])
  end
end
