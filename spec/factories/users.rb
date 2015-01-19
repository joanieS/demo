require 'faker'

FactoryGirl.define do
  factory :user do
  	association :customer
  		first_name { Faker::Name.first_name }
  		last_name { Faker::Name.last_name }
  		email { Faker::Internet.email }
  		username { Faker::Internet.user_name }
    	password { Faker::Internet.password(10) }
  end

end
