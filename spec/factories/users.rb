FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation {password}
    nickname { Faker::Name.last_name }
    family_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    icon {[Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test_image.png'))]}
  end
end