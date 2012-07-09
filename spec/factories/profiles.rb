# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    first_name "MyString"
    last_name "MyString"
    user_id 1
    user_name "iamawesome"
    about "MyString"
  end
end
