#TODO user_nameとの対応がちゃんとなってるかどうか注意
#そもそも
require 'active_support'
require 'pry'
require_relative 'auc.rb'
require_relative 'algorithms.rb'

id = ARGV[0]

season1_result = ActiveSupport::JSON.decode(File.read(id + "/season1_result"))
season2_result = ActiveSupport::JSON.decode(File.read(id + "/season2_result"))
season3_result = ActiveSupport::JSON.decode(File.read(id + "/season3_result"))
season4_result = ActiveSupport::JSON.decode(File.read(id + "/season4_result"))

actually_unfollowed = ActiveSupport::JSON.decode(File.read(id + "_unfollowed"))
#ユーザーのインデックス対応表とか
users_1 = File.read(id + "/user_order_1").split("\n")
users_2 = File.read(id + "/user_order_2").split("\n")
users_3 = File.read(id + "/user_order_3").split("\n")
users_4 = File.read(id + "/user_order_4").split("\n")
name_to_id = ActiveSupport::JSON.decode(File.read(id +"_name_to_id"))
user_name = name_to_id.find{|e| e[0].to_s == id}[1]
#ここのメソッドを入れ替えて評価方法を変えるみたいなことにする　最終的に別ファイルにするのかもしれんが
def diff_culc(json, user_name,user_order)
  user_index = user_order.find_index{|e| e.include?(user_name)}
  array_zero = json[user_index].sort_by{|k,v| v}
  result_diffpoints = []
  json.each_with_index do |array, array_num|
    array = array.sort_by{|k,v| v}
    diff_point = 0
    array_zero.each_with_index do |e,i|
      array.each_with_index do |ee, ii|
        if e[0] == ee[0]
          diff_point += (i - ii).abs
        end
      end
    end
    result_diffpoints.push([array_num, diff_point])
  end
  return result_diffpoints
end

result1 = sum_of_index(season1_result, user_name, users_1)
result2 = sum_of_index(season2_result, user_name, users_2)
result3 = sum_of_index(season3_result, user_name, users_3)
result4 = sum_of_index(season4_result, user_name, users_4)
#=> あとはuser_orderと紐付ける

u1 = users_1.map{|u|  u.split("/")[1].split("?")[0]}
u2 = users_2.map{|u|  u.split("/")[1].split("?")[0]}
u3 = users_3.map{|u|  u.split("/")[1].split("?")[0]}
u4 = users_4.map{|u|  u.split("/")[1].split("?")[0]}

score_array = []
#season1のスコア
u1.each_with_index do |user,i|
  score_array.push([user,result1[i][1]])
end
u2.each_with_index do |user, i|
  if score_array.map{|e| e[0]}.include?(user)
    index = score_array.find_index{|a| a[0] == user}
    score_array[index][1] += result2[i][1]
  else
    score_array.push([user,result2[i][1]])
  end
end

u3.each_with_index do |user, i|
  if score_array.map{|e| e[0]}.include?(user)
    index = score_array.find_index{|a| a[0] == user}
    score_array[index][1] += result3[i][1]
  else
    score_array.push([user,result3[i][1]])
  end
end

u4.each_with_index do |user, i|
  if score_array.map{|e| e[0]}.include?(user)
    index = score_array.find_index{|a| a[0] == user}
    score_array[index][1] += result4[i][1]
  else
    score_array.push([user,result4[i][1]])
  end
end

#actually_unfollowed & name_to_id.map{|n_i| n_i[0].to_s}
#[2] pry(main)> name_to_id.count
#=> 102
#[3] pry(main)> actually_unfollowed.count
#=> 53
#[4] pry(main)> score_array.count
#=> 117
#これにかぎってやれば運良くアンフォローが補足してない115に含まれてなければどうにかなるけど、まあ後々のことを考えるとやっといたほうが良いよなあ

binding.pry
#一応計測メソッドは一通り実装した？あとは新しいデータ収集及び論文執筆
p auc_score(score_array, actually_unfollowed, name_to_id)
