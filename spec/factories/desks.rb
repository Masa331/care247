# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :desk do
    name {Faker::Name.first_name}
    notificate {Faker::Internet.email "Boss"}
    desks_mailbox {Faker::Internet.email "info"}
    resolved_requests 3
    unresolved_requests 1
    user_id 1
  end
end
