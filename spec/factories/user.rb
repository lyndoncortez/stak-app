FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Johnny#{n}" }
    email { 'johndoe@example.com' }
    password { '123456' }
    type { 'Admin' }
    approved { 'true' }
  end
end
