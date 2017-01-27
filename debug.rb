require "twitter"
require "yaml"
require "pry"
require "redis"
require "hiredis"


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
redis = Redis.new(host: "127.0.0.1", port: 6379, db:1)

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
#=begin
##### TWEET検索　なんか最近のやつ取れてないけど基本的にこんなかんじで良さそう
#最悪これで探索できる？まあ時間ヤバイけど……
max_id = "999999999999999999"
max_id_old = ""
tweets = []
tweet_texts = []
#result =  client.search("from:@minjinaffa since:2012-10-01 until:2016-10-31",count: 100)


#followsの右側だけ読むメソッド
#多分左=>右のフォロー問題
=begin
#File.open("follows_of_330032737","w+") do |file1|
ids = [1475800723,1554838951,1883259144,3019251372,3104526234,3309771264,3356110393,433830036,515649925]
ids.each do |id|
  File.open("follows_ja_inter_#{id}", "r") do |file1|
    File.open("follows_of_#{id}","w+") do |file2|
      file1.each_line do |line|
        #file1.puts line.chop.split("\t")[1]
        array = line.chop.split("\t")
        if array[0] == id.to_s
          file2.puts array[1]
        else
          next
        end
      end
    end
  end
end
=end

#各follows_ofファイルを読んでどうするんだっけ……先に年月ごとにわけるんだっけ？？？？
#先に全部ツイートを取ってしまう
#それをトピック分析して……？時期ごとに取るんだっけ
#完全に忘れた　一人あたり取るのにそんなに時間かからなかったし大丈夫?
#とりあえず全発言をid 発言　時期ということで全ログを取っといたらいいのかもしれない　そうるか
#セーブを実装したい　せめて実装のアイデアだけでも出して寝たい
#冷静に考えると単にセーブ用のファイルを別に用意する　まあそれがよさそう
#このループの最初にまずセーブファイル（目標idとその中のフォロイーid）を読み込んで
#file読み込みでそこまでスキップする的な
#=begin
#ids = [1475800723,1554838951,1883259144,3019251372,3104526234,3309771264,433830036,515649925]
#ids.each do |id|
  #File.open("save_data","r+") do |sd|
    #sd.puts "id:#{id}"
    #if redis.get("now_id").nil?
    #  redis.set("now_id",id)
    #end
    #if id != redis.get("now_id")
    #  next
    #end
id = 433830036
    File.open("#{id}_follows_tweets","a") do |file1|
    #user_name = client.user(id).screen_name
      File.open("follows_of_#{id}", "r") do |file2|
        file2.each_line do |line|
          max_id = "999999999999999999"
          max_id_old = ""
          tweet_datas = []
          tweet_texts = []
          begin
            user_name = client.user(line.to_i).screen_name
          rescue => ex
            p ex
            next
          end
          while (max_id_old != max_id) do
            begin
              result = client.search("from:@#{user_name} max_id:#{max_id} since:2015-12-28" , modules: "status")
              result.attrs[:modules].each {|t| tweet_datas.push("#{user_name} #{t[:status][:data][:text]} #{t[:status][:data][:created_at]}")}
            rescue => ex
              p ex
            end
            if result.attrs[:modules].last.nil?
              break
            end
            begin
              max_id_old = max_id
              max_id = result.attrs[:modules].last[:status][:data][:id]
              puts "#{user_name}: " + result.attrs[:modules].last[:status][:data][:created_at]
              sleep(1)
            rescue
              binding.pry
            end
          end
          p tweet_datas
          tweet_datas.each do |t|
            file1.puts t
          end
          puts "now:follows of #{id}"
        end
      end
    #end
  end
#end
#=end
#############################################################
#######お気に入り#########
#max_id方式で同様にやれる？
#p client.favorites(screen_name:"@yu3mars",count: 200,max_id:"789107813716889600")
#やれそう。
