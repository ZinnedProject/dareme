# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user_id 1
    event_time  '01/01/2012'
    title "DO IT NOW"
    location "madison, wi"
    minimum_raise 9.99
    raise_end "01/01/2012"
    description "MyText"
    custom_url 'gogogo'
  end
end
