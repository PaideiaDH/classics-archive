module RssFeedsHelper
  include HTTParty

  def valid_feed?(url)
    response = HTTParty.get(url).headers
    response['content-type'].include? 'xml' || 'json'
  end
end
