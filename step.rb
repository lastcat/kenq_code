
#初期状態
#/codes
##{id}_follows_tweets のみで行ける？

`mkdir seasons documents tweets`
`ruby codes/tweet_get.rb`
#=> tweets/以下に該当ユーザーのつぶやきが出てくる

`ruby codes/kenkyu.rb` #user名に_があるとアレだったのでセパレーターを?にしている
`ruby codes/kenkyu_u.rb` #同上。正規表現を調整する必要があるならそうする

# document生成
`ruby codes/documents_make.rb`

#掃除系　document_cleanは不要なのかなあ……
`gsed -i -e '1d' documents/*documents`
`gsed -i -e '/^ *$/d' docunments/*documents`

[1,2,3,4].each do |i|
  `ruby codes/gyousuu.rb #{i}`
  `ruby codes/document_connector.rb #{i}`
end
#{}`gsed -i -e '1d' season?1?documents`
`gsed -i -e '/^ *$/d' season?1?documents`
#{}`gsed -i -e '1d' season?2?documents`
`gsed -i -e '/^ *$/d' season?2?documents`
#{}`gsed -i -e '1d' season?3?documents`
`gsed -i -e '/^ *$/d' season?3?documents`
#{}`gsed -i -e '1d' season?4?documents`
`gsed -i -e '/^ *$/d' season?4?documents`
#documentの先頭付与
gyousuu_1 = `wc season?1?documents`.split(" ")[0]
gyousuu_2 = `wc season?2?documents`.split(" ")[0]
gyousuu_3 = `wc season?3?documents`.split(" ")[0]
gyousuu_4 = `wc season?4?documents`.split(" ")[0]

`sh codes/document_gyou.sh #{gyousuu_1} 1`
`sh codes/document_gyou.sh #{gyousuu_2} 2`
`sh codes/document_gyou.sh #{gyousuu_3} 3`
`sh codes/document_gyou.sh #{gyousuu_4} 4`

`/Users/nakaji/kenkyuu/433830036/GibbsLDA/src/lda -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 1000 -savestep 100 -twords 20 -dfile season\?1\?documents`
`mkdir season1_model`
`mv model* season1_model/`
`/Users/nakaji/kenkyuu/433830036/GibbsLDA/src/lda -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 1000 -savestep 100 -twords 20 -dfile season?2?documents`
`mkdir season2_model`
`mv model* season2_model/`

`/Users/nakaji/kenkyuu/433830036/GibbsLDA/src/lda -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 1000 -savestep 100 -twords 20 -dfile season?3?documents`
`mkdir season3_model`
`mv model* season3_model/`

`/Users/nakaji/kenkyuu/433830036/GibbsLDA/src/lda -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 1000 -savestep 100 -twords 20 -dfile season?4?documents`
`mkdir season4_model`
`mv model* season4_model/`
#model_kaiseki, removal_userで多分どうにか
