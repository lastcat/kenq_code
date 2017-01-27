require "twitter"
require "yaml"
require "pry"
require "redis"
require "hiredis"
require 'active_support'
require 'active_support/core_ext'


client = Twitter::REST::Client.new do |config|
  #config.consumer_key        = "T4m3q17djVhCiUGkjhX9A"
  #config.consumer_secret     = "smVeHCn5w1Qok58rAjAOR9cPMtV53MuTjeYCtZlN4Mg"
  config.consumer_key        = "IQKbtAYlXLripLGPWd0HUA"
  config.consumer_secret     = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"
  #config.access_token        = "173891634-yBfRWayToocpihkIJqdxvjpmF1h0PY2EBFj5H42E"
  #config.access_token_secret = "j7GYxUNq927RJuttYBgAUvkX7Usb5jRM1oZtIsYUdapLv"
  #config.access_token        = "2854581781-40QJt9naqRUTWduTLohlWyyqwlUhOoPhqc41cQJ"
  #config.access_token_secret = "OkWk8nyRuem2ngiJ1sC2IJEb8YNYAP4OkoDzZ7wqNFEPb"
  config.access_token = "2854581781-U0bebYxCxbTHkA4hRTxgAV8Qm7lqgoyuhTWHLG6"
  config.access_token_secret = "jhkrhN4ffhVzT4iIzilKzw2v7MczStx1BRx7tCKW7Wxyp"
end

module Twitter
  class SearchResults
    def next_page
      return nil unless next_page?
      hash = query_string_to_hash(@attrs[:search_metadata][:next_results])
      since_id = @attrs[:search_metadata][:since_id]
      hash[:since_id] = since_id unless since_id.zero?
      hash
    end
  end
end

max_id = "999999999999999999"
max_id_old = ""
tweets = []
tweet_texts = []

id = Dir.pwd.split("/").last.to_i
user_name = client.user(id).screen_name

File.open("tweets/#{user_name}_tweets","w+") do |file1|
#user_name = client.user(id).screen_name

      max_id = "999999999999999999"
      max_id_old = ""
      tweet_datas = []
      tweet_texts = []
      one_years_ago = Time.new(2015,12,28)
      while (max_id_old != max_id) do
        begin
          #binding.pry
          result = client.user_timeline(user_name, max_id:"#{max_id}", count:"200")
          #result = client.search("from:@#{user_name} max_id:#{max_id} since:2015-12-28" , modules: "status")
          result.each do |t|
            if t.created_at < one_years_ago
              break
            end
            tweet_datas.push("#{user_name} #{t.text} #{t.created_at}")
          end
          p result
        rescue => ex
          p ex
        end
        begin
          max_id_old = max_id
          max_id = result.last.id
          sleep(1)
        rescue
        end
      end
      p tweet_datas
      tweet_datas.each do |t|
        file1.puts t
      end
end
#######お気に入り#########
#max_id方式で同様にやれる？
#p client.favorites(screen_name:"@yu3mars",count: 200,max_id:"789107813716889600")
#やれそう。
