class SearchController < ApplicationController
  before_action :set_client

  def index
    search_param = params['query']

    query_string = "Retorne todos os versículos com o termo: #{search_param}. Os versículos deverão estar separados por tags html de lista desordetada"

    if ENV['OPENAI_ACCESS_TOKEN'].present? && !ENV["TEST"]
      response = @client.chat(
        parameters: {
          model: ENV["OPENAI_CURRENT_MODEL"],
          messages: [{ role: 'user', content: query_string }]
        }
      )

      gpt_response = response.dig("choices", 0, "message", "content")
    else
      gpt_response = "
        <ul>
          <li>Jonas 1:2 - \"Levanta-te, vai à grande cidade de Nínive e clama contra ela, porque a sua malícia subiu até à minha presença.\"</li>
          <li>Jonas 3:3 - \"E levantou-se Jonas, e foi a Nínive, segundo a palavra do SENHOR. Ora, Nínive era uma cidade muito grande, de três dias de caminho.\"</li>
          <li>Jonas 3:4 - \"E começou Jonas a entrar pela cidade caminho de um dia, e pregava, dizendo: Ainda quarenta dias, e Nínive será subvertida.\"</li>
        </ul>
      "
    end

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
