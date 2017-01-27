require "pry"
require "csv"
require 'natto'
require 'uri'
#seasonごとにわけるやつ

#File.open("nero3133_tweets", "r") do |file|

File.open("#{Dir.pwd.split("/").last}_follows_tweets", "r") do |file|
  #これはserrch/univiersal APIで取得した祭のregex(debug.rb)
  reg = /[A-Za-z0-9_]+ (?m:(.)+?) (Sun|Mon|Thu|Wed|Tue|Fri|Sat) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) ([0-3][0-9]) (0|1|2)([0-9]):([0-5])([0-9]):([0-5])([0-9]) (\+0000) (2016|2015)/
  mode = 0
  #こっちはuser_timelineで取得した方のregex(tweet_get.rb)
  #reg = /[A-Za-z0-9_]+ (?m:(.)+?) (2016|2015|2017)\-([0-1][0-9])\-([0-3][0-9]) (0|1|2)([0-9]):([0-5])([0-9]):([0-5])([0-9]) (\+0000)/
  #mode = 1

  result =  file.read.match(reg)
  #あとはresult[3]でmonth result[4]でday result[12]で年齢を参照できるのでガーッと回してどうにかする
  user_name = ""
  period_year = ""
  period_month = ""
  months_hash = {"Jan" => 1, "Feb" => 2,"Mar" => 3,"Apr" => 4,"May" => 5,"Jun" => 6,"July" => 7,"Aug" => 8,"Sep" => 9,"Oct" => 10,"Nov" => 11,"Dec" => 12}
  #これで months_hash[result[3]] in [1..3] or [4..6] or [7..9] or [10..12]とかで多分できる
  #12だけはめんどうで(ほんと面倒で) その際だけyearと使う
  #実質にはif 12ならyear 2015?2016?ってやって各SEASONファイルに入れるということになるのかなあ
  while(result != nil) do
    #ユーザー切り替わりチェック
    if user_name != result[0].split(" ")[0]
      puts "new_file: #{result[0].split(" ")[0]}"
      #binding.pry
      user_name = result[0].split(" ")[0]
    end

    #　この辺も書き換えが必要ですよ
    #followsの場合はmonths_hash[result[3]]
    #個人の場合はresult[3].to_i
    month = months_hash[result[3]].to_i
    if  [2,3].include?(month)
      season = "1"
    elsif [4,5,6].include?(month)
      season = "2"
    elsif [7,8,9].include?(month)
      season = "3"
    elsif [10,11].include?(month)
      season = "4"
    else
      if result[12] == "2015"
        season = "1"
      else
        season = "4"
      end
    end
    #binding.pry

    File.open("seasons/#{user_name}?season?#{season}", "a") do |f_file|
      f_file.puts result[0].split(" ")[1..-7].join(" ") #つぶやきの内容
    end
      result = $'.match(reg)
  end
end
#まあ大体こんな感じかなあ　後はノイズフィルタリングをどの段階でするか　まあここから先は撮っちゃってとりあえず試行錯誤すればいい説あるけど？
#今日中にこのファイルの生成までいきたい。
#resultはこんなかんじ
=begin
"kurisionkurisi2 @Neck____\nいたw https://t.co/fan0hRcLSz Sun Dec 11 06:33:59 +0000 2016"
1:"z"
2:"Sun"
3:"Dec"
4:"11"
5:"0"
6:"6"
7:"3"
8:"3"
9:"5"
10:"9"
11:"+0000"
12:"2016">
=end



=begin
nm = Natto::MeCab.new
csv_data = CSV.read(file,headers: true)
File.open("documents.txt", "w+") do |file|
  csv_data.each do |data|
    #ここに適切な処理をしたのち、カウントする
    #適切な処理　名詞、動詞のみにする　urlも除く
    #urlを除く
    text = data["text"].gsub(URI.regexp(%w(http https)),"")
    #リプライを除く　ただしRTは含む
    next if text.include?("@") && !text.include?("RT")

    document = ""
    #名詞、動詞のみにする
    nm.parse(text) do |e|
      f= e.feature.split(",")[0]
      if f=="名詞" || f=="動詞"
        document += "#{e.surface} "
        #puts e.surface
      end
    end
    file.puts document.chop if document.chop != ""
  end
end
=end
