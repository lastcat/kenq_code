#empty documentのemptyドキュメントを削除する
#=begin
filenames = Dir.glob("datas/*_season_1_documents")
str = ""
filenames.each do |file_name|
  File.open(file_name, "r") do |file|
    str = file.read.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8')
    str = str.gsub(/\n\n/,"\n")
  end
  File.open(file_name, "w") do |file|
    file.write str
  end
end
#=end
=begin

str = ""
File.open("test.txt", "r") do |file|
  str = file.read.gsub(/\n\n/, "\n")
end
File.open("test.txt", "w") do |file|
  file.write str
end
=end
