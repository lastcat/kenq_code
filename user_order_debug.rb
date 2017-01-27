require 'pry'

count = 0
File.open("user_order_1","r") do |o_file|
File.open("user_order_4","r") do |f_file|
  while true
    count += 1
    o = o_file.gets.split(",")[0].split("_")[0..-3].join("_")
    f = f_file.gets.split(",")[0].split("_")[0..-3].join("_")
    if o != f
      binding.pry
    end
  end
end
end
