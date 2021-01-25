# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description { Faker::Movie.title }
    status 'to-do'
    user { FactoryBot.create(:user) }
  end
end
