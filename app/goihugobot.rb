
require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Commands::CommandBot.new token:ENV["TOKEN"], client_id: ENV["CLIENT_ID"], prefix: '/'

bot.command :hello do |event|
 event.send_message("こんにちは。#{event.user.name}")
end
# 語彙リストを初期化した後登録
bot.command :create do |event|
  event.send_message("語彙を5つ入力してください。#{event.user.name}(まだ未実装です)")
  # 変えたら任意のチャンネルに投下
end


# 語彙リストを表示
#bot.command :list do |event|
bot.command :list do |event|
#  File.open(../goi/{event.userame}.txt)
#  event.end_message()
#end
  event.send_message("#{event.user.name}の語彙リストです。(まだ未実装です)")
end

# 語彙リストの中から番号に対応した語彙を表示
bot.command :cast do |event|
  event.send_message("まだ未実装です。#{event.user.name}")
end

# ヘルプ表示
bot.command :help do |event|
  event.send_message(" /hello : 挨拶します
  ----------------------未実装---------------------
  /create : 語彙リストを作成します
  /list : 語彙リストを見せます
  /cast [番号] : 語彙リストの中から番号に対応した語彙を表示します
  /help : 今開いてるのはなんですか？
  ----------------------謎機能---------------------
  /fenia : フェニアを召喚します")
end

bot.command :fenia do |event|
  event.send_message(":hatched_chick: フェニアだよ！")
  end

bot.run
