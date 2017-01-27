#各シーズンごとの結果ファイルを読んでremove候補を上か列挙する
#各ファイルに結果が読み込めたとする(result)
require 'active_support'
require 'pry'

season1_result = ActiveSupport::JSON.decode(File.read("season1_result"))
season2_result = ActiveSupport::JSON.decode(File.read("season2_result"))
season3_result = ActiveSupport::JSON.decode(File.read("season3_result"))
season4_result = ActiveSupport::JSON.decode(File.read("season4_result"))

#ユーザーのインデックス対応表とか
users_1 = File.read("user_order_1").split("\n")
users_2 = File.read("user_order_2").split("\n")
users_3 = File.read("user_order_3").split("\n")
users_4 = File.read("user_order_4").split("\n")

def diff_culc(json)
  array_zero = json[0].sort_by{|k,v| v}
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

result1 = diff_culc(season1_result)
result2 = diff_culc(season2_result)
result3 = diff_culc(season3_result)
result4 = diff_culc(season4_result)
#=> あとはuser_orderと紐付ける

u1 = users_1.map{|u| u.split(",")[0].split("_season_1_documents")[0]}
u2 = users_2.map{|u| u.split(",")[0].split("_season_2_documents")[0]}
u3 = users_3.map{|u| u.split(",")[0].split("_season_3_documents")[0]}
u4 = users_4.map{|u| u.split(",")[0].split("_season_4_documents")[0]}

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
#たぶん　これで取れてると思うんだけど・・・
#あとは実際のアンフォローと比較する
now_follows =  ActiveSupport::JSON.decode(File.read("../now_follows_433830036"))
old_follows = File.read("../follows_of_433830036").split("\n")
binding.pry
p score_array
