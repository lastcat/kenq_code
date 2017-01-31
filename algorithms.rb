#評価方法
#正規化するかは置いておいて。=>いる気がする
#とりあえず一段落
include Math
def kl_diver(season,user_name,user_order)
  #基本的に各シーズンごとに ユーザーのトピックの値 * log(ユーザーのトピック値/比較対象のユーザーのトピック値)を出していくだけ
  user_index = user_order.find_index{|e| e.include?(user_name)}
  array_zero = season[user_index]
  result_diffpoints = []
  #各ユーザーについて
  season.each_with_index do |p_array, index|
    diff_point = 0
   array_zero.each_with_index do |zero_p, t_index|
     #p zero_p
     #p p_array
     diff_point += zero_p[1] * Math.log(zero_p[1]/p_array[t_index.to_s])
   end
   result_diffpoints.push([index, diff_point])

  end
  #p result_diffpoints
  result_diffpoints

end

##1位のトピックの順位差　課題:当然ながら0にやつごろごろいる
def first_topic(season, user_name, user_order)
  #目的ユーザーのindex
  user_index = user_order.find_index{|e| e.include?(user_name)}
  #目的ユーザーのトピック配列
  array_zero = season[user_index].sort_by{|e| e[1]}.reverse
  #各ユーザーとの差スコアの配列
  result_diffpoints = []


  season.each_with_index do |p_array, i|
    diff_point = 0
    p_array.sort_by{|k,v| v}.reverse.each_with_index do |e, index|
      if(array_zero[0][0] == e[0])
        diff_point = index
      end
    end
    result_diffpoints.push([i, diff_point])
  end
  result_diffpoints
end

#同トピックの確率値の和(積?)の最小値
def sum_of_index(season, user_name, user_order)
  #正規化
  season = season.map{|e| normalize(e)}
  #目的ユーザーのindex
  user_index = user_order.find_index{|e| e.include?(user_name)}
  #目的ユーザーのトピック配列
  array_zero = season[user_index].sort_by{|e| e[1]}.reverse
  #各ユーザーとの差スコアの配列
  result_score = []
  score_array = []
  season.each_with_index do |each_user, i|
    #arrayzero eの２つの同トピックの積で最大のものをスコアとする
    array_zero.each do |user_topic|
      each_user.each do |e_u|
        score_array.push(user_topic[1] * e_u[1]) if user_topic[0] == e_u[0]
      end
    end
    result_score.push([i,score_array.max])
    score_array = []
  end
  result_score
end

#トピックスコア配列正規化メソッド
def normalize(array)
  normalized_array = []
  sum = 0
  array.each do |e|
    sum += e[1]
  end
  array.each do |e|
    normalized_array.push([e[0],e[1]/sum])
  end
  normalized_array
end
