# coding: utf-8

require 'discordrb'
require 'dotenv'


GOI_ARR_LENGTH = 5

Dotenv.load

bot = Discordrb::Commands::CommandBot.new token:ENV["TOKEN"], client_id: ENV["CLIENT_ID"], prefix: '/'

bot.command :hello do |event|
 event.send_message("こんにちは。#{event.user.name}")
end

# 語彙リストを初期化した後登録 ===================================================
bot.command :create do |event|
  #event.send_message("語彙を5つ入力してください。#{event.user.name}(まだ未実装です)")
  #event.send_message("#{event.message}")
  eventstr = "#{event.message}"           # event.messageを文字列に変換
  goiarr = eventstr.split                 # 語彙の配列に分割
  goiarr.delete_at(0)                     # 先頭は /create のため削除
  goiarr = goiarr.uniq                    # 重複を削除

  if goiarr.length == GOI_ARR_LENGTH then
    event.send_message("語彙を登録します。#{event.user.name}")
    # tmp/ユーザ名.goiに保存
    fname = "tmp/#{event.user.name}.goi"
    File.open(fname,"w") do |f|
      goiarr.each do |i|
        f.puts(i)
      end
    end
    # goi/ユーザ名.txtに履歴として保存
    fname = "goi/#{event.user.name}.txt"
    File.open(fname,"a") do |f|
      goiarr.each do |i|
        f.puts(i)
      end
      f.puts("----------------------------------------")
    end
    # 変えたら任意のチャンネルにメッセージを投下(不正防止)
    bot.send_message(ENV["GENERAL_CHANNEL_ID"], "#{event.user.name}の語彙を登録しました。")
  else
    event.send_message("語彙を重複無く5つ入力してください。#{event.user.name}")
  end
end


# 語彙リストを表示 ==============================================================
#bot.command :list do |event|
bot.command :list do |event|
#  File.open(../goi/{event.userame}.txt)
#  event.end_message()
#end
  event.send_message("#{event.user.name}の語彙リストです。(まだ未実装です)")
end

# 語彙リストの中から番号に対応した語彙を表示 ======================================
bot.command :cast do |event|
  event.send_message("まだ未実装です。#{event.user.name}")
end

# ヘルプ表示  ==================================================================
bot.command :help do |event|
  event.send_message(" /hello : 挨拶します
  /create [重複なしの単語5つ] : 語彙リストを作成します

  ----------------------未実装---------------------
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
