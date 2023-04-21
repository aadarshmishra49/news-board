FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password {"pass123"} 

  end
end
