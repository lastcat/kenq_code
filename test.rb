
require "twitter"
require "pry"
require 'active_support'
require 'active_support/core_ext'
require 'json'


client = Twitter::REST::Client.new do |config|
  #config.consumer_key        = "IQKbtAYlXLripLGPWd0HUA"
  #config.consumer_secret     = "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU"
  #config.access_token = "2854581781-U0bebYxCxbTHkA4hRTxgAV8Qm7lqgoyuhTWHLG6"
  #config.access_token_secret = "jhkrhN4ffhVzT4iIzilKzw2v7MczStx1BRx7tCKW7Wxyp"
  config.consumer_key        = "T4m3q17djVhCiUGkjhX9A"
  config.consumer_secret     = "smVeHCn5w1Qok58rAjAOR9cPMtV53MuTjeYCtZlN4Mg"
  config.access_token = "3448181052-5mDcTFAnuUdGey953t3ejouHk91myBoIkiJ4L6b"
  config.access_token_secret = "KKhBck4dYnEv5EqFv83PnDGtxEFi3KSRdAwyG8935YhFz"
end

ids = ["1475800723", "3104526234", "433830036", "3019251372", "3356110393" ,"515649925"]
ids.each do |id|
  #この時点でのname_to_idはuser_order1にあったもの（つまり追跡出来ているかつ最初のz店でフォローされてたもの）
  name_to_id = ActiveSupport::JSON.decode(File.read(id +"_name_to_id"))
  unfollowed_ids = ActiveSupport::JSON.decode(File.read("#{id}_unfollowed"))

  binding.pry
end
