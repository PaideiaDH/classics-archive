include Aylien
require 'rest-client'
require 'unshorten'
require 'uri'

module TweetToDumpedLink
  def get_tweets
    all = []
    twit = Twitter::REST::Client.new(
      consumer_key: ENV['OPCA_TWITTER_KEY'],
      consumer_secret: ENV['OPCA_TWITTER_SECRET'],
      access_token: ENV['OPCA_TOKEN'],
      access_token_secret: ENV['OPCA_TOKEN_SECRET']
    )
    twit.mentions_timeline.each do |tweet|
      text = tweet.text
      url = Unshorten[URI.extract(text, %w[http https])[0]]
      all << url
    end
    all
  end

  def tweet_to_link(url)
    article = article_info(url)
    existing_titles = Article.all.map(&:title).concat DumpedLink.all.map(&:title)
    unless existing_titles.include? article[:title]
      DumpedLink.create(
        title: article[:title],
        url: article[:url],
        submission_route: 'Twitter',
        rss_object: article.to_json
      )
    end
  end

  def self.check_feed
    feed = get_tweets
    feed.each do |link|
      tweet_to_link(link)
    end
  end
end
