FactoryBot.define do
  factory :choice do
    association :user
    association :recipe
  end
end
