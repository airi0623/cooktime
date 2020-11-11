
# CookTime
__URL__：URLを入れる
<img width="100%" alt="スクリーンショット 2020-11-11 16 37 42" src="https://user-images.githubusercontent.com/69624304/98783054-450c3e00-243c-11eb-8c8f-2e868f80f973.png">


__ログイン方法__

- リスト1
- リスト2
- リスト3

# このアプリでできること
__URL__：URLを入れる
<img width="100%" alt="スクリーンショット 2020-11-11 16 36 52" src="https://user-images.githubusercontent.com/69624304/98783105-59e8d180-243c-11eb-836b-90fdc3c98dc0.png">>

### 買い物リスト自動作成
選択したレシピに必要な材料リストをワンクリックで自動作成！

### 材料の自動計算
家族の人数を入力するとレシピの材料を自動計算！

### レシピ登録
おすすめレシピを登録して働くママ仲間をお助け！
自分のレシピメモにもお使いください♪

### お気に入りチェック
お気に入りのレシピをチェックしてマイページにストック!

# ターゲット・背景

__スライド画像で入れる__

# 使用技術
- HTML
- CSS
- Javascript / JQuery / Ajax
- Ruby 2.6.5
- Ruby on Rails 6.0.3.4
- MySQL 5.6.47
- AWS<br>
EC2 ( Amazon Linux 2 ) / RDS(MySQL) / S3 
- GitHub  

# 機能一覧
__USER__

- ユーザー登録・編集、ログイン機能全般 （gem:deviseを使用）
- ユーザープロフィール画像アップロード機能 （画像のアップロードにgem:CarrierWaveを使用）
- マイページ(登録したレシピ閲覧、お気に入りレシピの閲覧など)

__RECIPE__

- レシピ登録・編集 （画像のアップロードにgem:CarrierWaveを使用、材料投稿にgem:cocoonを使用）
- お気に入り登録機能 （Ajax / 非同期処理）
- レシピ選択機能 （Ajax / 非同期処理）
- レシピ検索機能 （gem: Ransackを使用）
- レシピお気に入りランキング表示

__その他__

- Bootstrapによるレスポンシブ対応
- モデルに対する複数バリデーション(文字数・メールアドレス・パスワードなど)
- Rspec / Rubocop テスト機能 【実装中】
