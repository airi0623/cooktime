FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    nickname { Faker::Name.last_name }
    family_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
  end
end