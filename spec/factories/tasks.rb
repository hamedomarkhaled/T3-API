FactoryBot.define do
  factory :task do
    description { Faker::Movie.title }
    status "to-do"
  end
end