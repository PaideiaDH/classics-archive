set :output, "log/cron_log.log"
env :PATH, ENV['PATH']
env :OPCA_TOKEN_SECRET, ENV['OPCA_TOKEN_SECRET']
env :OPCA_TWITTER_SECRET, ENV['OPCA_TWITTER_SECRET']
env :OPCA_TOKEN, ENV['OPCA_TOKEN']
env :OPCA_TWITTER_KEY, ENV['OPCA_TWITTER_KEY']
env :AYLIEN_ID, ENV['AYLIEN_ID']
env :AYLIEN_KEY, ENV['AYLIEN_KEY']
env :OPEN_CALAIS_ID, ENV['OPEN_CALAIS_ID']

every 15.minutes do
  rake "RSS:update"
  rake "Twitter:update"
  rake "all_articles:generate"
end
