# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content "Test Comment"
    user_id 1
#    commentable_type "event"
#    commentable_id 1
  end
end
