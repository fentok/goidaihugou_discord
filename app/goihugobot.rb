TOKEN = 'Mzg5NjAzOTk0NjMwMjI1OTIw.DQ_vRw.ghrwtSPzW6fxT19t6I54-XrucMc'
CLIENT_ID = 389603994630225920
TOKEN.freeze
CLIENT_ID.freeze

require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token:TOKEN, client_id: CLIENT_ID, prefix: '/'

bot.command :hello do |event|
 event.send_message("hallo,world.#{event.user.name}")
end

bot.run
