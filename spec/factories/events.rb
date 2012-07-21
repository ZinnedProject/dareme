# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user_id 1
    event_time  '01/01/2012'
    title "I am the strong!"
    location "madison, wi"
    minimum_raise 10
    raise_end "01/01/2012"
    description "This is perhaps the most important discovery of all time.  I will be jumping from a bridge and landing in a pool of water.  I will be traverseing the air and making sonic waves.  I am the awesome and you will pay me big monies.  I will wear a cape and fly.  I will crush cars.  I am the strong!"
    sequence :slug do |n|
      "slug_#{n}"
    end
  end
end
