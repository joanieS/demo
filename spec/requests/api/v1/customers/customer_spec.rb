require "rails_helper"
require 'pry'

RSpec.describe "customer" do

	describe 'GET api/v1/customers/:id' do
		it 'returns a customer by :id' do
			customer = create(:customer)
			installation = create(:installation, customer_id: customer.id)

			get 'api/v1/customers.json', id: customer.id

			expect(response.status).to eq 200

			body = JSON.parse(response.body)

			expect(body).to eq( 
				[{ 
					'id' => customer.id,
					'name' => customer.name,
					'category' => customer.category,
					'created_at' => customer.created_at.strftime('%FT%T.%LZ'),
					'updated_at' => customer.updated_at.strftime('%FT%T.%LZ'),
					'address' => customer.address,
					'installations' => [{
						'id' => installation.id,
						'name' => installation.name,
						'group' => installation.group,
						'customer_id' => installation.customer_id,
						'created_at' => installation.created_at.strftime('%FT%T.%LZ'),
						'updated_at' => installation.updated_at.strftime('%FT%T.%LZ'),
						'active' => installation.active,
						'image_url' => installation.image_url,
						'image_file_name' => installation.image_file_name,
						'image_content_type' => installation.image_content_type,
						'image_file_size' => installation.image_file_size,
						'image_updated_at' => installation.image_updated_at	
						}]
				}])

		end
	end

end 