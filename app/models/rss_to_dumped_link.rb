require 'rss'

module RSSToDumpedLink

  def get_feed(rss_url)
    response = HTTParty.get rss_url
    feed = RSS::Parser.parse response.body
  end

  def feed_to_link(parsed_feed)
    existing_titles = Article.all.map(&:title).concat DumpedLink.all.map(&:title)
    parsed_feed.items.each do |item|
      title = item.title
      unless existing_titles.include? title
        DumpedLink.create(
          title: title,
          url: item.link,
          submission_route: 'RSS Feed',
          rss_object: item.to_json
        )
      end
    end
  end

  def self.check_feeds
    RSS_SOURCES.each do |url|
      feed = get_feed(url)
      feed_to_link(feed)
    end
  end
end
