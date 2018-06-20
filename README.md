# goidaihugou_discord
Discord上で語彙大富豪をするのを支援するbotです。
rubyで動作します。


# 環境設定
- gemでdotenvとdiscordrbをインストール


# botの作成
- discord apps から新しいアプリを作成
- botユーザーを作成
- OAUTH2 URL GENERATORをクリックする
- SCOPESはbotのみ
- Bot PermissionsはView ChannelsとSend Messagesにする
- URLからBotをサーバーに認証する

# botの設定
- .envファイルに以下の項目を追加する。
  - TOKEN
  - CLIENT_ID 
  - GENERAL_CHANNEL_ID
-TOKENとCLIENT_IDはdiscord appsからコピペ
-GENERAL_CHANNEL_IDはサーバーの中で通知を飛ばしたいチャンネルのIDを記述

- `deck/deck.txt`に、山札から引かせたい単語を追加する。

# botの起動
`ruby app/goihugobot.rb`

# コマンドの実行方法
discord上で任意のコマンドを先頭につけて発言する。

現在以下のコマンドが実装されている

  - /hello : 挨拶します
  - /create [重複なしの単語5つ] : 語彙リストを作成します
  - /list : 語彙リストを見せます
  - /cast [1-5] : 語彙リストの中から番号に対応した語彙を表示します
  - /help : ヘルプを表示します
  - /deck : デッキからランダムに語彙を1つ表示します
  - /turn : 手番の順序を表示します

# botを使ったプレイの仕方
1. BOTに語彙を5つ登録する。悩んだら/deckコマンドでカードを引いて手札にしてもいい。
2. プレイヤーの順番を決める。
3. BOTのdeck機能を使い、山札から1枚場にカードを出し、最初のお題とする。
4. 順番に、場に置かれたカードよりも「強い」カードを出していく。
5. 誰もカードを出せなくなった場合、場を流す。山札から1枚、場にカードを出し、場に出ていたカードを出した人の先行で続行する。
6. ⑤の際、山札から引いたカードに誰も出せなかった場合、先行の人が好きなカードを1枚出してゲームを続行する。
7. 先に全ての手札を使い切った人が勝ち！
