require 'json'
require 'active_support'
require 'pry'

ids = ["1475800723", "3104526234", "433830036", "3019251372", "3356110393"]#,"515649925"]
ids.each do |id|
  now_follows =  ActiveSupport::JSON.decode(File.read("now_follows_#{id}"))
  old_follows = File.read("follows_of_#{id}").split("\n")
  File.open(id + "_unfollowed", "w+") do |file|
    file.puts (old_follows - now_follows.map{|e|e[0].to_s}).to_json
  end
end
