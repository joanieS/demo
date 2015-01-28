require 'rails_helper'

RSpec.describe BeaconsController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@installation = FactoryGirl.create(:installation, customer: @customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
		@beacon = FactoryGirl.create(:beacon, installation: @installation)
		sign_in
	end
	describe "GET #show" do
		it "renders a show page" do
			get :show, id: @beacon, customer_id: @customer, installation_id: @installation
				expect(response).to render_template("show")
		end

	end

	describe 'GET #new' do
	  it "assigns a new Beacon to @beacon" do
	    get :new, customer_id: @customer, installation_id: @installation
	    expect(assigns(:beacon)).to be_a_new(Beacon)
	  end

	  it "renders the :new template" do
	    get :new, customer_id: @customer, installation_id: @installation
	    expect(response).to render_template :new
	  end
	end

	describe 'GET #edit' do
	  it "assigns the requested beacon to @beacon" do
	    beacon = create(:beacon, installation_id: @installation.id)
	    get :edit, customer_id: @customer.id, installation_id: @installation.id, id: beacon
	    expect(assigns(:beacon)).to eq beacon
	  end

	  it "renders the :edit template" do
	    beacon = create(:beacon, installation_id: @installation.id)
	    get :edit, id: beacon, customer_id: @customer.id, installation_id: @installation.id
	    expect(response).to render_template :edit
	  end
	
	end

end
