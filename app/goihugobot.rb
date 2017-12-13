<<<<<<< HEAD
<<<<<<< HEAD

=======
TOKEN = 'uVjsQdmxZbgrkceqMPVaowWXiIV8zKa'
>>>>>>> parent of 16ec8cd... test
=======
TOKEN = 'Mzg5NjAzOTk0NjMwMjI1OTIw.DQ_vRw.ghrwtSPzW6fxT19t6I54-XrucMc'
>>>>>>> parent of c43409a... いろいろ
CLIENT_ID = 389603994630225920
TOKEN.freeze
CLIENT_ID.freeze
#認証用URL
#https://discordapp.com/api/oauth2/authorize?client_id=389603994630225920&permissions=75776&scope=bot

require 'discordrb'

<<<<<<< HEAD
<<<<<<< HEAD
bot = Discordrb::Commands::CommandBot.new token:ENV["TOKEN"], client_id: CLIENT_ID, prefix: '/'
=======
bot = Discordrb::Commands::CommandBot.new token:TOKEN, client_id: CLIENT_ID, prefix: '/'
>>>>>>> parent of c43409a... いろいろ

bot.command :hello do |event|
 event.send_message("こんにちは。#{event.user.name}")
end

# 語彙リストを初期化した後登録
bot.command :create do |event|
  event.send_message("語彙を5つ入力してください。#{event.user.name}(まだ未実装です)")
end


# 語彙リストを表示
#bot.command :list do |event|
#  File.open(../goi/{event.userame}.txt)
<<<<<<< HEAD
  event.send_message("#{event.user.name}の語彙リストです。(まだ未実装です)")
=======
bot = Discordrb::Bot.new token: TOKEN, client_id: CLIENT_ID

bot.message do |event|
    event.respond 'Hello, world!'
>>>>>>> parent of 16ec8cd... test
end
=======
#  event.end_message()
#end
>>>>>>> parent of c43409a... いろいろ

# 語彙リストの中から番号に対応した語彙を表示

bot.run
