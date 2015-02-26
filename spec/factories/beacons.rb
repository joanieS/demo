require 'factory_helper.rb'

FactoryGirl.define do

	factory :beacon do
		association :installation 
		minor_id { Faker::Number.positive }
		content_type { "Web"}
		active {"true"}
		content { Faker::Internet.url }
	end

end