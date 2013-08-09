# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    street {Faker::Address.street_name}
    city {Faker::Address.city}
    zip_code {Faker::Address.zip_code}
    country {Faker::Address.country}
    ic {Faker::Number.number 8}
    dic {Faker::Code.isbn 8}
    phone {Faker::PhoneNumber.phone_number}
    email {Faker::Internet.email "Petr"}
    password_hash {Faker::Internet.password}
    password_salt {Faker::Internet.password}
  end
end
