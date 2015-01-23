require 'spec_helper'
require 'pry'


RSpec.describe InstallationsController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@installation = FactoryGirl.create(:installation, customer: @customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
		@installations = @customer.installations
		@active_installations = @installations.where(:active => true)
		@user = FactoryGirl.create(:user, customer: @customer)
		session[:user_id] = @user.id
		@installation_attributes = FactoryGirl.attributes_for(:installation, :customer_id => @customer)
	end

	describe "GET #index " do

		it "blocks unauthenticated access" do
		   sign_in nil

		   get :index, id: @installation, customer_id: @customer.id

		   response.should redirect_to(new_user_session_path)
		 end

		 it "allows authenticated access" do
		   sign_in

		   get :index, id: @installation, customer_id: @customer.id

		   response.should be_success
		 end

		it 'requires login' do
			get :index, id: @installation, customer_id: @customer.id
			expect(response).to redirect_to '/users/sign_in'
		end

		it "renders an index page" do

			sign_in

			get :index, id: @installation, customer_id: @customer.id

			expect(response).to render_template :index

		end
	end

	describe "GET #show" do
		context 'when user is logged in' do
			it 'displays the show page' do
				sign_in

				get :show, id: @installation, customer_id: @customer.id

				expect(response).to render_template :show

			end
		end
	end


	# describe "GET new" do
	#   it "assigns a new installation as @installation" do
	#   	sign_in
	#     get :new, {}
	#     assigns(:installation).should be_a_new(Installation)
	#   end
	# end

	describe 'POST #create' do

		context 'with valid attributes' do

			it 'saves the installation in the database' do
				sign_in
				current_user = @user
				expect { 
					post :create, :customer_id => @user.customer_id, :installation => @installation_attributes
				}.to change(Installation, :count).by(1)

			end

			it 'redirects to installations#show' do
				sign_in
				post :create, :customer_id => @user.customer_id, :installation => @installation.attributes
				
				expect(response).to redirect_to customer_installation_path(:customer_id => @customer.id, :id => Installation.last.id)

			end

			it 'saves the installation under the current user' do
				sign_in
				expect(@installation.customer_id).to be(@user.customer_id)
			end
		end

	
	end


end