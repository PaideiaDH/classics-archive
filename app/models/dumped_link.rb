# links submitted via rss feeds or twitter
class DumpedLink < ActiveRecord::Base
  attr_accessor :publication

  def publication
    uri = URI.parse(url)
    host = uri.host
    parsed_host = host.gsub(/^www./, '').split('.')[0]
    parsed_host
  end
end
