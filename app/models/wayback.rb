require 'faraday'

module Wayback
  def archive(url)
    request_body =
    conn = Faraday.new(url: "https://web.archive.org/save")
    conn.get "/#{url}"
  end
  def get_wayback_id(url)
    resp = archive(url)
    return url
  end
end
