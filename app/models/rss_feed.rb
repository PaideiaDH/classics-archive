class RssFeed < ApplicationRecord
  include RssFeedsHelper

  validate :valid_feed_url, on: :create

  def valid_feed_url
    errors.add(:feed_url, "<a href='https://www.lifewire.com/find-an-rss-feed-on-a-website-3486647' target='_blank'>must be valid address of RSS Feed</a> (of type 'xml' or 'json')") unless valid_feed?(feed_url)
  end
end
