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
        phone {Faker::Number.digit}
        email {Faker::Internet.email "Petr"}
        password "foobar"
        admin false
    end

    factory :invalid_user, parent: :user do
        name nil
        password nil
        phone "asdkjcabn"
    end

    factory :admin, parent: :user do
        admin true
    end

    factory :whitelist, class: User do
        name {Faker::Name.name}
        email {Faker::Internet.email "Petr"}
        password "foobar"
    end

    factory :non_whitelist, class: User do
        name nil
    end
end
