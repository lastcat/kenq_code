require 'pry'

def auc_score(sorted_score, actually_unfollowed, id_to_name)
  unf_num = 0
  score = 0
  sorted_score.each do |s|
    if id_to_name.find{|i_n| i_n[1] == s[0] && actually_unfollowed.include?(i_n[0].to_s)} #とりあえずこれでいけるやん
      unf_num += 1
    end
    puts unf_num
    score += unf_num
  end
  score
end
