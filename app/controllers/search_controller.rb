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
    ).dig("choices", 0, "message", "content")

    @response = build_array_response gpt_response
  end

  private

  def set_client
    @client = OpenAI::Client.new
  end

  def build_array_response text
    fragment = Nokogiri::HTML5.fragment(text)
    search_elements fragment
  end

  def search_elements fragment
    fragment.search('li')
      .to_a
      .map{ |element| p element.content.tr("“", "").tr("”", "") }
  end
end
