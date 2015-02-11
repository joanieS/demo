require 'rails_helper'
require 'spec_helper'

RSpec.describe CustomersController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
		@user = FactoryGirl.create(:user, customer: @customer)
	end
	describe "GET #index" do

		it "allows unauthenticated access" do
			sign_in nil
			get :index
			response.should be_success
		end

		it "allows authenticated access" do
			sign_in
			get :index
			response.should be_success
		end


		it "renders an index page" do
			get :index
				expect(response).to render_template("index")
		end

	end

	describe "GET #show" do
		it "displays the show page" do
			sign_in(user = @user)
			get :show, id: @customer

			expect(response).to render_template :show
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

	describe 'POST #create' do
		context 'with valid attributes' do

			it 'creates a new customer' do
				valid_customer = Customer.create(:name => "Valid Customer", :category => "Museum", :address => "1621 Euclid Avenue, Cleveland Ohio 44114")
				valid_customer.should be_an_instance_of Customer
			end

			it 'redirects to the customer#show page on save' do
				sign_in
				post :create, customer: FactoryGirl.attributes_for(:customer)
				expect(response).to redirect_to customer_path(id: Customer.last.id)
			end

			it 'saves the customer in the database' do
				sign_in(user = FactoryGirl.create(:user, customer: nil))

				expect {
					post :create, :customer => FactoryGirl.attributes_for(:customer)
				}.to change(Customer, :count).by(1)
			end

		end

		context 'with invalid attributes' do

			it 'does not save the new customer in the database' do
				expect {
					post :create, :customer => FactoryGirl.attributes_for(:customer, :name => nil)
				}.to_not change(Customer, :count)
			end

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

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it "locates the requested @customer" do 
				patch :update, id: @customer, customer: FactoryGirl.attributes_for(:customer) 
				assigns(:customer).should eq(@customer) 
			end

			it 'updates the requested @customer' do 
				patch :update, id: @customer, customer: FactoryGirl.attributes_for(:customer, name: "Updated Customer")
				@customer.reload
				expect(@customer.name).to eq("Updated Customer")
			end

			it 'redirects to the updated customer' do
				patch :update, id: @customer, customer: FactoryGirl.attributes_for(:customer)
				expect(response).to redirect_to @customer
			end
		end
	end

	describe 'DELETE #destroy' do

		before :each do
			@delete_customer = FactoryGirl.create(:customer)
			sign_in(user = FactoryGirl.create(:user, customer: @delete_customer))
		end

		it 'deletes the customer' do
			expect{
				delete :destroy, id: @delete_customer
			}.to change(Customer, :count).by(-1)

		end

		it 'redirects to customers#index' do
			delete :destroy, id: @delete_customer
			expect(response).to redirect_to customers_url
		end

	end


end
