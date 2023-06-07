class SearchController < ApplicationController
  before_action :set_client

  def index
    @response = ''

    gpt_response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo-0301',
        messages: [{ role: 'user', content: 'Me diga olá!' }]
      }
    )

    @response = gpt_response.dig("choices", 0, "message", "content")
  end

  private

  def set_client
    @client = OpenAI::Client.new
  end
end
