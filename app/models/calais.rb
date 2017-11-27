# use OpenCalais to grab keywords from boilerpipe text for tags
require 'open_calais'

module Calais
  def calais(text)
    tags = []
    open_calais = OpenCalais::Client.new(api_key: ENV['OPEN_CALAIS_ID'])
    response = open_calais.enrich(text)
    response.tags.each { |tag| tags << tag[:name] }
    tags
  end

  def get_tags(article)
    text_to_parse = article.boilerpipe_text
    calais(text_to_parse)
  end
end
