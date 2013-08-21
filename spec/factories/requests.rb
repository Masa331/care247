# encoding: UTF-8

FactoryGirl.define do
    factory :request do
        to {Faker::Internet.email "to_user"}
        from {Faker::Internet.email "from_user"}
        subject {Faker::Lorem.word}
        status_flag 0
        desk_id "321"
        user_id "1"
    end
end