FactoryBot.define do
  factory :ingredient do
    amount {Faker::Number.between(from: 2, to: 99)}
    thing_id {Faker::Number.between(from: 2, to: 5)}
    association :recipe
  end
end
