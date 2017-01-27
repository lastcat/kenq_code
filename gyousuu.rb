require "pry"
#行数消すのはこれで行ける
#gsed -i -e '1d' datas/*_season_1_documents
#空白行削除?
#gsed -i -e '/^ *$/d'
#season_fileに行数を加える
#src/lda -est -alpha 0.5 -beta 0.1 -ntopics 100 -niters 1000 -savestep 100 -twords 20 -dfile models/casestudy/trndocs.dat
filenames = Dir.glob("documents/*?season?#{ARGV[0].to_s}?documents")
#binding.pry
filenames.each do |f_name|
  File.open(f_name, "r+") do |file|

    line_number = (file.read.scrub("").count("\n") + 1)
    #puts line_number
    file.rewind
    file.puts line_number
  end
end
