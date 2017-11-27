namespace :RSS do
  desc 'updates incoming with RSS feeds'
  task update: :environment do
    include RSSToDumpedLink
    RSSToDumpedLink.check_feeds
    puts "Feeds updated #{Time.now}"
  end
end

namespace :Twitter do
  desc 'updates incoming with Twitter mentions'
  task update: :environment do
    include TweetToDumpedLink
    TweetToDumpedLink.check_feed
    puts "Twitter feeds updated #{Time.now}"
  end
end
