FactoryBot.define do
  factory :buyer do
    sequence(:name) { |n| "Emily#{n}" }
    email { 'emilydavidson@example.com' }
    password { '123456' }
    type { 'Buyer' }
    approved { 'true' }
  end
end
