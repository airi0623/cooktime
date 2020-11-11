
# CookTime
__URL__：
__TOP画像を入れる__
<img width="100%" alt="cooktime-main" src="https://user-images.githubusercontent.com/69624304/98782205-eabead80-243a-11eb-8bf9-c61055e3f41f.png">


__ログイン方法__

- リスト1
- リスト2
- リスト3

# このアプリでできること
__URL__：
__画像を入れる__
<img width="100%" alt="cooktime-main" src="https://user-images.githubusercontent.com/69624304/98782205-eabead80-243a-11eb-8bf9-c61055e3f41f.png">


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
