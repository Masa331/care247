# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part do
    request_id "123"
    body "0s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsu"
    user_id "1"
  end
end
