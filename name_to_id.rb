require 'twitter'
require 'pry'
require 'json'
require 'active_support'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "IQKbtAYlXLripLGPWd0HUA"
  config.consumer_secret     = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"
  config.access_token = "2854581781-U0bebYxCxbTHkA4hRTxgAV8Qm7lqgoyuhTWHLG6"
  config.access_token_secret = "jhkrhN4ffhVzT4iIzilKzw2v7MczStx1BRx7tCKW7Wxyp"
end
#実際にツイートを観測出来た中でのアンフォローを見てみる
ids = ["1475800723", "3104526234", "433830036", "3019251372", "3356110393" ,"515649925"]
ids.each do |id|
  name_to_id = []

    #すべてのシーズンについてやる必要がある気がする　とりあえずは1だけで
    usernames = File.read("#{id}/user_order_1").split("\n").map do |line|
      begin
        line.split("/")[1].split("?")[0]
      rescue
        next
      end
    end
    usernames.compact!
    usernames.each do |username|
      begin
        name_to_id.push([client.user(username).id, username])
      rescue => ex
        p ex
        next
      end
    end
    File.open("#{id}_name_to_id", "w+") do |file|
      file.puts name_to_id.to_json
    end
    sleep 900
end
