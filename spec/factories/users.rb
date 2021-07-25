FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}