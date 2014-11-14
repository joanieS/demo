require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do

	describe "GET #index" do
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

	end

	describe 'GET #new' do
	  it "assigns a new Customer to @customer" do
	    get :new
	    expect(assigns(:customer)).to be_a_new(Customer)
	  end

	  it "renders the :new template" do
	    get :new
	    expect(response).to render_template :new
	  end
	end

	describe 'GET #edit' do
	  it "assigns the requested customer to @customer" do
	    customer = create(:customer)
	    get :edit, id: customer
	    expect(assigns(:customer)).to eq customer
	  end

	  it "renders the :edit template" do
	    customer = create(:customer)
	    get :edit, id: customer
	    expect(response).to render_template :edit
	  end
	
	end

end
