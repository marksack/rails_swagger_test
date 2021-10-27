FactoryBot.define do
  factory :account, class: Account do
    email { Faker::Internet.unique.email }
    password { '123456'}
  end
end