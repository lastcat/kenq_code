#なるべくrakeやらシェルスクリプトに任せることを目標にする　これを今日中に実装する
#初期時点各idディレクトリは以下のような構造
# - codes/ rubyコードの集まり
# - 1475800723_follows_tweets
# - datas/

# アカウントの本来のフォローを確認しておく。
#　 => 本来ならばnow_follows_check.rbで住んでいるはず。将来的にユーザーを増やすのであれば回す必要はあるが、
#      基本的に終わってるはず
#調査対象のツイートも基本的に取得されてるはず
#実行は
# まず各人のtweetのseason分け

ruby codes/kenkyu.rb #user名に_があるとアレだったのでセパレーターを?にしている
ruby codes/kenkyu_u.rb #同上。正規表現を調整する必要があるならそうする

# document生成
ruby codes/document_make.rb

#掃除系　document_cleanは不要なのかなあ……
gsed -i -e '1d' datas/*documents
gsed -i -e '/^ *$/d' datas/*documents


ruby codes/gyousuu.rb 1
ruby codes/gyousuu.rb 2
ruby codes/gyousuu.rb 3
ruby codes/gyousuu.rb 4
ruby codes/document_connector.rb 1
ruby codes/document_connector.rb 2
ruby codes/document_connector.rb 3
ruby codes/document_connector.rb 4

/Users/nakaji/kenkyuu/433830036/GibbsLDA/src/lda -est -alpha 0.5 -beta 0.1 -ntopics 20 -niters 1000 -savestep 100 -twords 20 -dfile <連結されたドキュメント>
model_kaiseki, removal_userで多分どうにか
