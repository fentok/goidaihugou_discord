CLIENT_ID = 389603994630225920
TOKEN.freeze
CLIENT_ID.freeze
#認証用URL
#https://discordapp.com/api/oauth2/authorize?client_id=389603994630225920&permissions=75776&scope=bot

require 'discordrb'
require 'dotenv'

bot = Discordrb::Bot.new token:ENV["TOKEN"], client_id: CLIENT_ID
bot.message do |event|
  event.respond '私もそう思います'
end
bot.run
