require 'factory_helper.rb'

FactoryGirl.define do

	factory :beacon do
		association :installation 
		minor_id { Faker::Number.positive }
		active {"true"}

		trait :web_content do
			content_type { "Web"}
			content { Faker::Internet.url }
		end

		trait :image_content do
			
		end

	end

end