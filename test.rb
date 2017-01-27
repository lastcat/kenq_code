
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

binding.pry
p clinet.user
