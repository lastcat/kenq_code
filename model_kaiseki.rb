#結果解析用
require 'pry'
require 'json'
require 'active_support'
#まあまあできてる？　ちゃんとユーザーごとに分けられえてるかだけチェック
result = []
user_array = []
season = ARGV[0]
File.open("user_order_#{season}", "r").each_line do |u_line|
  #p_array = Array.new(101,0)
  p_hash = Hash.new
  user_name = u_line.split(",")[0]
  #p_hash[0]  = user_name
  user_array.push(user_name)
  line_number = u_line.split(",")[1].to_i
  line_count = 0
File.open("season#{season}_model/model-01000.theta", "r").each_line do |t_line|
  if line_number == line_count
    break
  end
  array = t_line.split(" ")
  array.each_with_index do |pro, i|
    if line_count == 0
      p_hash[i] = array[i].to_f
    end
    begin
    p_hash[i] += array[i].to_f
    rescue
      #binding.pry
    end
  end
  line_count += 1
end
#多分確率は集計できてるとしよう
#p p_hash
result.push(p_hash)
end

File.open("season#{season}_result", "w") do |file|
  file.puts result.to_json
end
File.open("user_list","w"){|file| file.puts user_array.to_json}
#ここからどうするか

#result.each_with_index.select{|e,i| e.sort_by{|k,v| v}[0][0] == 9}.map{|e| e[1]}.map{|id| user_array[id]}
