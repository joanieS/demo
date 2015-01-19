require 'factory_helper.rb'
require 'pry'

FactoryGirl.define do

	factory :customer do

		name { Faker::Company.name }
		category "Museum"
		address { "123 Ottawa Avenue North, Golden Valley, Minnesota 55422"}
	end

end