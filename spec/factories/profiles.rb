# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    first_name "Donald"
    last_name "Driver"
    user_id 1
    about "I'm a long time pro athlete and I'm here to stay.  I have no regrets only dreams I wish to accomplish."
  end
end
