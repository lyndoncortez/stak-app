FactoryBot.define do
  factory :broker do
    sequence(:name) { |n| "Johnny#{n}" }
    email { 'johndoe@example.com' }
    password { '123456' }
    type { 'Broker' }
    approved { 'true' }
  end
end
