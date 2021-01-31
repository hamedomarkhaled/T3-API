# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id 100
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password 'foobar'
  end
end
