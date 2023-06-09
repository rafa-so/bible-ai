class SearchController < ApplicationController
  before_action :set_client

  def index
    search_param = params['query']

    query_string = "Retorne todos os versículos com o termo: #{search_param}.
      Os versículos deverão estar separados por tags html de lista desordetada"

    gpt_response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo-0301',
        messages: [{ role: 'user', content: query_string }]
      }
    )

    @response = gpt_response.dig("choices", 0, "message", "content")
  end

  private

  def set_client
    @client = OpenAI::Client.new
  end
end
