FactoryBot.define do
  factory :user do
    name { 'Name' }
    email { 'test@test.com' }
    customer_id { '123' }
    password { 'abc' }
  end

  factory :account do
    user
    sequence :se_id do |n|
      "se_id_#{n}"
    end
    connection_id { '321' }
    name { 'Account Name ' }
    nature { 'card' }
    balance { 100.0 }
    currency_code { 'EUR' }
  end
end
