require 'faraday'

module Wayback
  def archive(url)
    request_body =
    conn = Faraday.new(url: 'https://pragma.archivelab.org') do |builder|
      builder.request  :json
      builder.response :logger
      builder.adapter  :net_http
    end
    conn.post do |req|
      req.url ''
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        url: url,
        annotation: {
          message: 'an article shared with the Online Public Classics Archive'
          }
        }
    end
  end
  def get_wayback_id(url)
    resp = archive(url)
    JSON.parse(resp.body)['wayback_id']
  end
end
