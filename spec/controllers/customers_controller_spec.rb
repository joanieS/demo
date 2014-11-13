require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do

	describe "GET index" do
		it "renders an index page" do
			get :index
				expect(response).to render_template("index")
		end

		it "can count customers" do
			@customers = Customer.all
			expect(@customers.count).to eq(Customer.all.count)
		end

		it "can list customers" do
			customer = Customer.create(:name => "Example")
			installation = Installation.create(:active => false, :customer_id => customer.id)
			active_installations = Installation.where(:customer_id => customer.id, :active => true)
			expect(active_installations.count).to eq(0)
		end

		it 'requires login' do
			get :index
			expect(response).to require_login
		end
	end
end
