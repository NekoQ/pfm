FactoryBot.define do
  # factory :api_key do
  #   name       { "test" }
  #   key_type   { ApiKey::APP }
  #   status     { ApiKey::ACTIVE }
  #   public_key { File.open("#{Rails.root}/config/test_public.pem", "r").read }
  #   client_id  { 123 }
  #   application_id { client.try(:default_application).try(:id) }
  # end
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
