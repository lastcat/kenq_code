require "pry"
require "csv"
require 'natto'
require 'uri'

nm = Natto::MeCab.new

#filenames = Dir.glob("datas/*?season?*")
filenames = Dir.glob("datas/rouma_p?season?*")
filenames.each do |filename|
  File.open(filename, "r") do |season_file|
    File.open(filename+"?documents", "w+") do |document_file|
      season_file.each_line do |line|
        #URI,リプライIDおよびノイズを除く
        line = line.gsub(URI.regexp(%w(http https)), "")
        line = line.gsub(/@[a-z0-9A-Z_]+/, "")
        line = line.gsub(/\(\)/,"")

        document = ""
        #名詞、動詞のみにする
        nm.parse(line) do |e|
          f = e.feature.split(",")[0]
          if f=="名詞" || f=="動詞"
            document += "#{e.surface} "
            #puts e.surface
          end
        end
        document_file.puts document.chop if document.chop != ""
      end
    end
  end
end
#  end
#end

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
