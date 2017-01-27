#実際に

require "twitter"
require "pry"
require 'active_support'
require 'active_support/core_ext'
require 'json'


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "IQKbtAYlXLripLGPWd0HUA"
  config.consumer_secret     = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"
  config.access_token = "2854581781-U0bebYxCxbTHkA4hRTxgAV8Qm7lqgoyuhTWHLG6"
  config.access_token_secret = "jhkrhN4ffhVzT4iIzilKzw2v7MczStx1BRx7tCKW7Wxyp"
end


=begin
now_follows_1475800723 = client.friends("rouma_p").map{|u| [u.id, u.screen_name]}
File.open("now_follows_1475800723", "w+") do |f|
  f.puts now_follows_1475800723.to_json
end
sleep 10
=end
#=begin
now_follows_433830036 = client.friends("nero3133").map{|u| [u.id, u.screen_name]}
File.open("now_follows_433830036", "w+") do |f|
  f.puts now_follows_433830036.to_json
end
sleep 10
=begin
begin
  now_follows_1554838951 = client.friends("kurokumi22").map{|u| [u.id, u.screen_name]}
  File.open("now_follows_1554838951", "w+") do |f|
    f.puts now_follows_1475800723.to_json
  end
rescue => ex
  p ex
end

sleep 10

begin
  now_follows_3019251372 = client.friends("kanemachi23").map{|u| [u.id, u.screen_name]}
  File.open("now_follows_3019251372", "w+") do |f|
    f.puts now_follows_1475800723.to_json
  end
rescue => ex
  p ex
end

sleep 10

begin
  now_follows_3104526234 = client.friends("1155James55").map{|u| [u.id, u.screen_name]}
  File.open("now_follows_3104526234", "w+") do |f|
    f.puts now_follows_1475800723.to_json
  end
rescue => ex
  p ex
end

sleep 10

begin
  now_follows_3356110393 = client.friends("yui728tosaka").map{|u| [u.id, u.screen_name]}
  File.open("now_follows_3356110393", "w+") do |f|
    f.puts now_follows_1475800723.to_json
  end
rescue => ex
  p ex
end

sleep 10

begin
  now_follows_515649925 = client.friends("amediaana").map{|u| [u.id, u.screen_name]}
  File.open("now_follows_515649925", "w+") do |f|
    f.puts now_follows_1475800723.to_json
  end
rescue => ex
  p ex
end
=end
