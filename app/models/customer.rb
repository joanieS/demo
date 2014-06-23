class Customer < ActiveRecord::Base
	has_many :installations
end
