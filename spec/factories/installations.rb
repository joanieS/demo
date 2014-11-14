require 'faker'

FactoryGirl.define do
	factory :installation do
		association :customer
		name { Faker::App.name }
		active "true"
		image_url { Faker::Avatar.image }
	end
end