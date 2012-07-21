# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	 sequence :email do |n|
      "email_#{n}@daremenow.com"
    end
  	password 'afwefdf'
  	 sequence :slug do |n|
      "slug_#{n}"
    end
  end
end
