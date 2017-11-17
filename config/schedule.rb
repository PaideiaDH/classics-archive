env :PATH, ENV['PATH']

every 2.minutes do
  rake "RSS:update"
  rake "Twitter:update"
end
