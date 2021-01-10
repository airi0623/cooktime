FactoryBot.define do
  factory :recipe do
    title { Gimei.first.kanji }
    feature {Faker::Base.regexify("[aあ]{1,100}")}
    eat {Faker::Base.regexify("[aあ]{1,100}")}
    category_id {Faker::Number.between(from: 2, to: 6)}
    cold_date {Faker::Number.between(from: 2, to: 99)}
    frozen_date {Faker::Number.between(from: 2, to: 99)}
    time {Faker::Number.between(from: 2, to: 999)}
    text {Faker::Base.regexify("[aあ]{1,100}")}
    # images {[Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test_image.png'))]}
    association :user 
    #json型で画像を保存するときは[]でデータを囲む・配列にしていないと入力エラーが発生する

    # trait :with_images do
    #   images { File.new("#{Rails.root}/spec/fixtures/test_image.png") }
    # end
  end
end
