# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user_id 1
    event_date 1
    title "MyString"
    location "MyString"
    minimum "9.99"
    duration ""
    description "MyText"
  end
end
