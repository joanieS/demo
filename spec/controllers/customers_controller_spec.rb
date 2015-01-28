require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)

	end
	describe "GET #index" do
		it "renders an index page" do
			get :index
				expect(response).to render_template("index")
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
