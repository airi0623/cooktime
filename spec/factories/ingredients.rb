FactoryBot.define do
  factory :ingredient do
    amount {Faker::Number.between(from: 2, to: 99)}
    thing_id {Faker::Number.between(from: 2, to: 5)}
    name {Faker::Base.regexify("[aあ]{1,8}")}
    association :recipe
    association :thing
  end
end
