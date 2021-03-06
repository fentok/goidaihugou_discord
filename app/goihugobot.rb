# coding: utf-8

require 'discordrb'
require 'dotenv'

CORDING_MODE = "utf-8:sjis"
GOI_ARR_LENGTH = 5

Dotenv.load

# デッキ配列
deck = []
deck_init = []

# 参加者の順序配列
turn = []

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
bot.command :list do |event|
  fname = "tmp/#{event.user.name}.goi"
  begin
    File.open(fname, "r:"+CORDING_MODE) do |f|
      event.send_message("#{event.user.name}の語彙リストです。")
      # 行:語彙の書式で出力
      str = ""
      value = 1
      f.each_line do |labman|
        str << value.to_s()
        str << ": "
        str << labman
        value += 1
      end
      event.send_message(str)
    end
    # エラーコード
  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
    event.send_message("#{event.user.name}の語彙リストを読み込めません")
  rescue IOError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
    event.send_message("#{event.user.name}の語彙リストを読み込めません")
  end
end

# 語彙リストの中から番号に対応した語彙を表示 ======================================
bot.command :cast do |event|
  fname = "tmp/#{event.user.name}.goi"
  # 表示する語彙に対応する番号
  castnum = "#{event.message}".split()[1].to_i()
  puts(castnum.to_s())
  if (castnum >= 1 && castnum <=5) then
    begin
      File.open(fname, "r:"+CORDING_MODE) do |f|
        str = f.readlines[castnum-1]
        event.send_message(str)
      end
      # エラーコード
    rescue SystemCallError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
      event.send_message("#{event.user.name}の語彙リストを読み込めません")
    rescue IOError => e
      puts %Q(class=[#{e.class}] message=[#{e.message}])
      event.send_message("#{event.user.name}の語彙リストを読み込めません")
    end
  else
    event.send_message("以下のように入力してください。\n/cast [1-5]")
  end
end

# デッキからランダムに1枚表示、デッキ生成 ========================================
bot.command :deck do |event|
  option = "#{event.message}".split()[1]
  case option
  # オプションinit deck配列にデッキテキストを流し込む
  when "init" then
    fname = "deck/deck.txt"
    begin
      File.open(fname) do |file|
        deck = file.read.split()
        deck_init = deck
      end
      event.send_message("デッキを初期化しました。")
    # エラーコード
    rescue SystemCallError => e
      event.send_message("デッキを読み込めません")
    rescue IOError => e
      event.send_message("デッキを読み込めません")
    end
  # deckのランダムな箇所を表示して削除
  else
    if (deck.nil? || deck.empty?) then
      event.send_message("デッキを初期化してください。\n/deck init")
    else
      rand_num = rand(deck.length)
      str = deck[rand_num]
      event.send_message("ドロー！")
      deck.delete_at(rand_num)
    end
  end
end

# 参加者の順序 =================================================================
bot.command :turn do |event|
  event_split = "#{event.message}".split()
  option = event_split[1]
  case option
  # 参加者を登録してランダムな順序にする
  when "init" then
    turn = event_split
    turn.slice!(0..1)
    if (turn.empty?) then
      event.send_message("参加者を一人以上入力してください。")
      break
    end
    turn.shuffle!
    event.send_message("参加者を登録しました。")
    str = ""
    turn.each.with_index(1) do |a,i|
      str << i.to_s() + ": " + a + "\n"
    end
    event.send_message(str)
  else
    if (option.nil?) then
      if (turn.nil? || turn.empty?) then
        event.send_message("参加者を登録してください。\n/turn init [参加者]")
      else
        str = ""
        turn.each.with_index(1) do |a,i|
          str << i.to_s() + ": " + a + "\n"
        end
        event.send_message(str)
      end
    else
      event.send_message("正しいコマンドを入力してください。")
    end
  end
end

# ヘルプ表示  ==================================================================
bot.command :help do |event|
  event.send_message(" /hello : 挨拶します
  /create [重複なしの単語5つ] : 語彙リストを作成します
  /list : 語彙リストを見せます
  /cast [1-5] : 語彙リストの中から番号に対応した語彙を表示します
  /help : ヘルプを表示します
  /deck : デッキからランダムに語彙を1つ表示します
  /turn : 手番の順序を表示します")
end


bot.run
