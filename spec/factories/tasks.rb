# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description { Faker::Movie.title }
    status 'to-do'
    user_id 1
  end
end
