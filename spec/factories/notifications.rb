# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    content "MyText"
    notifiable_id 1
    notifiable_type "MyString"
  end
end
