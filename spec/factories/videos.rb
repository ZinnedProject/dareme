# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    title "Awesome vid of car blowing up"
    description "I want to blow up my car"
    yt_video_id "yt_unique_id"
    is_complete true
    event_id 1
    event_video_type "request"
  end
end
