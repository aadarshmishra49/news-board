FactoryBot.define do
  factory :author do
    email { Faker::Internet.email }

    password {"pass123"} 

  end
end
