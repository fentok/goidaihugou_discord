TOKEN = 'uVjsQdmxZbgrkceqMPVaowWXiIV8zKa'
CLIENT_ID = 389603994630225920
TOKEN.freeze
CLIENT_ID.freeze

require 'discordrb'

bot = Discordrb::Bot.new token: TOKEN, client_id: CLIENT_ID

bot.message do |event|
    event.respond 'Hello, world!'
end

bot.run
