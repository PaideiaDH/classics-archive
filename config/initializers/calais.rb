require 'open_calais'

OpenCalais.configure do |c|
  c.api_key = ENV['OPEN_CALAIS_ID']
end
