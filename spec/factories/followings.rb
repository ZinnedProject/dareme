# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :following do
    user_id 1
    followable_id 1
    followable_type 'User'
  end
end
