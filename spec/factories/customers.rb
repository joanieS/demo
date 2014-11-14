require 'factory_helper.rb'

FactoryGirl.define do
	factory :customer do
		name { Faker::Company.name }
		category "Museum"
		address FactoryHelper.full_address
	end
end