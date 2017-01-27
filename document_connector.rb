#別に特別扱いじゃなくてもよくない？
#対象:nero3133
season = ARGV[0]
File.open("season?#{season}?documents", "w+") do |file|
  File.open("user_order_#{season}","w+") do |order_file|
    filenames = Dir.glob("documents/*?season?#{season}?documents")
    filenames.each do |file_name|
      File.open(file_name, "r") do |f|
        line_number = f.gets
        order_file.puts "#{file_name},#{line_number}"
        str = f.read
        file.puts(str)
      end
    end
  end
end
