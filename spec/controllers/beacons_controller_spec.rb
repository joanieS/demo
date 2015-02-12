require 'rails_helper'
require 'spec_helper'

RSpec.describe BeaconsController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@installation = FactoryGirl.create(:installation, customer: @customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
		@beacon = FactoryGirl.create(:beacon, installation: @installation)
		@user = FactoryGirl.create(:user, customer: @customer)
		sign_in(user = @user)
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

	describe 'POST #create' do

		context 'with valid attributes' do

			it 'saves the beacon in the database' do

				expect{
					post :create, customer_id: @customer.id, installation_id: @installation, beacon: FactoryGirl.attributes_for(:beacon)
				}.to change(Beacon, :count).by(1)
			end

			it 'redirects to beacon#show' do

				# beacon = FactoryGirl.attributes_for(:beacon, installation_id: @installation.id)

				post :create, customer_id: @customer.id, installation_id: @installation.id, beacon: FactoryGirl.attributes_for(:beacon, installation_id: @installation.id)
				
				expect(response).to redirect_to customer_installation_beacon_path(:customer_id => @customer.id, :installation_id => @installation.id, :id => Beacon.last.id) 

				# expect(response).to redirect_to customer_installation_path(:customer_id => @customer.id, :id => Installation.last.id)
			end

		end

		# context 'with invalid attributes' do

		# 	it 'does not save the beacon in the database' do
		# 		expect {
		# 			post :create, customer_id: @customer.id, installation_id: @installation, beacon: FactoryGirl.attributes_for(:beacon, minor_id: "xyzabc")
		# 		}.to_not change(Beacon, :count)
		# 	end

		# end

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

	describe 'PATCH #update' do
		it "locates the requested @beacon" do 
			put :update, id: @beacon, customer_id: @customer.id, installation_id: @installation.id, beacon: FactoryGirl.attributes_for(:beacon) 
			assigns(:beacon).should eq(@beacon) 
		end

		it 'changes the beacon attributes' do
			patch :update, id: @beacon, customer_id: @customer.id, installation_id: @installation.id, beacon: FactoryGirl.attributes_for(:beacon, active: false)
			@beacon.reload
			expect(@beacon.active).to eq(false)
		end

		it 'redirects to the updated beacon' do
			patch :update, id: @beacon, customer_id: @customer.id, installation_id: @installation.id, beacon: FactoryGirl.attributes_for(:beacon, active: false)
			expect(response).to redirect_to customer_installation_beacon_path(@customer, @installation, @beacon)
		end
	end

	describe 'DELETE destroy' do

		before :each do
			@delete_beacon = FactoryGirl.create(:beacon, installation: @installation)
		end

		it 'deletes the beacon' do

			expect{
				delete :destroy, id: @delete_beacon, customer_id: @customer.id, installation_id: @installation.id
			}.to change(Beacon, :count).by(-1)

		end

		it 'redirects to installation_path' do

			delete :destroy, id: @delete_beacon, customer_id: @customer.id, installation_id: @installation.id
			expect(response).to redirect_to customer_installation_path(@customer, @installation)
		end


	end





end
