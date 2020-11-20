FactoryBot.define do
  factory :user do
    icon {[Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test_image.png'))]}
    nickname { Faker::Name.last_name }
    profile {Faker::Base.regexify("[aあ]{1,100}")}
    family_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    email { Faker::Internet.free_email}
    password { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation {password}
  end
end