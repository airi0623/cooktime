# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

#Thingのデータ作成
Thing.create(thing_name:'にんじん', kana:'にんじん',spoon:'', unit:'本')
Thing.create(thing_name:'大根', kana:'だいこん', spoon:'', unit:'本')
Thing.create(thing_name:'じゃがいも', kana:'じゃがいも', spoon:'', unit:'個')
Thing.create(thing_name:'ねぎ', kana:'ねぎ', spoon:'', unit:'本')
Thing.create(thing_name:'ブロッコリー', kana:'ぶろっこりー', spoon:'', unit:'g')
Thing.create(thing_name:'レモン', kana:'れもん', spoon:'', unit:'個')
Thing.create(thing_name:'きゅうり', kana:'きゅうり', spoon:'', unit:'本')
Thing.create(thing_name:'玉ねぎ', kana:'たまねぎ', spoon:'', unit:'個')
Thing.create(thing_name:'茄子', kana:'なすび', spoon:'', unit:'個')
Thing.create(thing_name:'トマト', kana:'とまと', spoon:'', unit:'個')
Thing.create(thing_name:'水', kana:'みず', spoon:'', unit:'ml')
Thing.create(thing_name:'醤油', kana:'しょうゆ', spoon:'大さじ', unit:'')
Thing.create(thing_name:'みりん', kana:'みりん', spoon:'大さじ', unit:'')
Thing.create(thing_name:'カレールー', kana:'かれーるー', spoon:'', unit:'g')
Thing.create(thing_name:'だし', kana:'だし', spoon:'小さじ', unit:'g')
Thing.create(thing_name:'鶏肉もも', kana:'とりにくもも', spoon:'', unit:'g')
Thing.create(thing_name:'鶏肉むね', kana:'とりにくむね', spoon:'', unit:'g')
Thing.create(thing_name:'豚肉肩ロース', kana:'ぶたにくかたろーす', spoon:'', unit:'g')
Thing.create(thing_name:'豚肉細切れ', kana:'ぶたにくこまぎれ', spoon:'', unit:'g')
Thing.create(thing_name:'豚肉バラ', kana:'ぶたにくばら', spoon:'', unit:'g')
Thing.create(thing_name:'牛肉ブロック', kana:'ぎゅうにくぶろっく', spoon:'', unit:'g')
Thing.create(thing_name:'牛肉細切れ', kana:'ぎゅうにくこまぎれ', spoon:'', unit:'g')
Thing.create(thing_name:'サーモン', kana:'さーもん', spoon:'', unit:'切')
Thing.create(thing_name:'豆腐', kana:'とうふ', spoon:'', unit:'切')
Thing.create(thing_name:'卵', kana:'たまご', spoon:'', unit:'個')
Thing.create(thing_name:'米', kana:'こめ', spoon:'', unit:'g')

# userのデータ作成
2.times do
  icon = open('./db/fixtures/icon.png')
  nickname  = Faker::Name.last_name 
  profile = Faker::Base.regexify("[aあ]{1,100}")
  family_name = Gimei.last.kanji
  first_name = Gimei.first.kanji
  email = Faker::Internet.free_email
  password = '1a1a1a1a'
  User.create!(
    icon:         icon,
    profile:      profile,
    nickname:     nickname,
    family_name:  family_name, 
    first_name:   first_name, 
    email:        email, 
    password:     password, 
    encrypted_password: password,
    created_at:         "2020-11-01 00:00:00",
    updated_at:         "2020-11-01 00:00:00"
  )
end

#recipeのデータ作成
20.times do
  user_id = Faker::Number.between(from: 1, to: 2)
  title = 'レシピタイトル'
  feature = 'テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。'
  eat = 'テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。'
  category_id = Faker::Number.between(from: 2, to: 6)
  cold_date = Faker::Number.between(from: 1, to: 10)
  frozen_date = Faker::Number.between(from: 1, to: 10)
  time  = Faker::Number.between(from: 2, to: 200)
  text = 'テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。テストで登録しているレシピです。'
  images = [open('./db/fixtures/test.png')]
  Recipe.create!(
    user_id:      user_id,
    title:        title,
    feature:      feature,
    eat:          eat,
    category_id:  category_id,
    cold_date:    cold_date,
    frozen_date:  frozen_date,
    time:         time,
    text:         text,
    images:       images,
    created_at:   "2020-11-01 00:00:00",
    updated_at:   "2020-11-01 00:00:00"
  )
end

# Ingredientのデータ作成
20.times do
  recipe_id = Faker::Number.between(from: 1, to: 20)
  thing_id = Faker::Number.between(from: 1, to: 25)
  name = "テスト"
  amount = Faker::Number.between(from: 2, to: 99)
  Ingredient.create!(
    recipe_id: recipe_id,
    thing_id:  thing_id,
    name:      name,
    amount:    amount,
    created_at:         "2020-11-01 00:00:00",
    updated_at:         "2020-11-01 00:00:00"
  )
end


# # お気に入りのデータ作成
20.times do
  recipe_id = Faker::Number.between(from: 1, to: 20)
  thing_id = Faker::Number.between(from: 1, to: 25)
  name = "テスト"
  amount = Faker::Number.between(from: 2, to: 99)
  Ingredient.create!(
    recipe_id: recipe_id,
    user_id:  thing_id,
    created_at:         "2020-11-01 00:00:00",
    updated_at:         "2020-11-01 00:00:00"
  )
end

Like.create(user_id: 7, recipe_id: 62)
Like.create(user_id: 7, recipe_id: 63)
Like.create(user_id: 5, recipe_id: 23)
Like.create(user_id: 5, recipe_id: 24)
Like.create(user_id: 5, recipe_id: 25)
Like.create(user_id: 5, recipe_id: 26)
Like.create(user_id: 5, recipe_id: 27)
Like.create(user_id: 5, recipe_id: 28)

# つくれぽのデータ作成
10.times do
  user_id = Faker::Number.between(from: 1, to: 2)
  recipe_id = Faker::Number.between(from: 1, to: 5)
  repo_image = open('./db/fixtures/test.png')
  repo = Faker::Base.regexify("[aあ]{1,100}")
  Report.create!(
    user_id:     user_id,
    recipe_id:   recipe_id,
    repo_image:  repo_image,
    repo:        repo,
    created_at:         "2020-11-01 00:00:00",
    updated_at:         "2020-11-01 00:00:00"
  )
end