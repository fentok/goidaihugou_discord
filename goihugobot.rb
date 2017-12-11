require 'discordrb'

TOKEN = 'cbsNf2HKV6APgJYH6V_XaQyqMONIw3_b'
CLIENT_ID = '389603994630225920'
TOKEN.freeze
CLIENT_ID.freeze

bot = Discordrb::Commands::CommandBot.new (
token: TOKEN,
client_id: CLIENT_ID,
prefix:'/',
)

bot.command :hello do |event|
 event.send_message("hallo,world.#{event.user.name}")
end

bot.run
