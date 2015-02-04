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


	describe "GET new" do
	  it "assigns a new installation as @installation" do
	  	sign_in
	    get :new, id: @installation, customer_id: @customer.id
	    assigns(:installation).should be_a_new(Installation)
	  end
	end

	describe 'POST #create' do

		context 'with valid attributes' do

			# it 'saves the installation in the database' do
			# 	sign_in
			# 	current_user = @user
			# 	expect { 
			# 		post :create, :customer_id => @user.customer_id, :installation => @installation_attributes
			# 	}.to change(Installation, :count).by(1)

			# end

			# it 'redirects to installations#show' do
			# 	sign_in
			# 	post :create, :customer_id => @user.customer_id, :installation => @installation.attributes
				
			# 	expect(response).to redirect_to customer_installation_path(:customer_id => @customer.id, :id => Installation.last.id)

			# end

			it 'saves the installation under the current user' do
				sign_in
				expect(@installation.customer_id).to be(@user.customer_id)
			end
		end

		context 'with invalid attributes' do

			it 'does not save the new installation in the database' do
				invalid_installation = Installation.create(:customer_id => @customer.id, :active => true, :image_url => "http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/178/original/final_scavenger_hunt_6.png?1422037076")
				expect{
					post :create, :customer_id => @user.customer_id, :installation => invalid_installation
				}.to_not change(Installation, :count)
			end

			it 're-renders the :new template' do
				invalid_installation = Installation.create(:customer_id => @customer.id, :active => true, :image_url => "http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/178/original/final_scavenger_hunt_6.png?1422037076")

				post :create, :customer_id => @user.customer_id, :installation => invalid_installation
			end

		end

	
	end

	describe 'PATCH #update' do
		context 'valid attributes' do
			it 'located the requested @installation' do
				sign_in
				patch :update, id: @installation.id, customer_id: @installation.customer_id, installation: @installation_attributes
				expect(assigns(:installation)).to eq(@installation)
			end

			it 'changes @installation attributes' do
				sign_in
				patch :update, id: @installation.id, customer_id: @installation.customer_id, installation: attributes_for(:installation, name: "Updated Installation")
				@installation.reload
				expect(@installation.name).to eq("Updated Installation")				
			end

			it 'redirects to the updated contact' do
				sign_in
				patch :update, id: @installation, customer_id: @installation.customer_id, installation: @installation_attributes
				expect(response).to redirect_to customer_installation_path(:customer_id => @customer.id, :id => @installation.id)
			end
		end

		context 'invalid attributes' do
			it 'does not change the installation attributes' do
				sign_in
				installation = Installation.create(:customer_id => @customer.id, :name => "Installation", :active => true, :image_url => "http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/178/original/final_scavenger_hunt_6.png?1422037076")
				patch :update, id: @installation, customer_id: installation.customer_id, installation: attributes_for(:installation, name: nil, image_url: "http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/170/original/final_scavenger_hunt_6.png?1422037076")
				@installation.reload

				expect(installation.image_url).to_not eq("http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/170/original/final_scavenger_hunt_6.png?1422037076")
				expect(installation.name).to eq("Installation")
			end

			it 're-renders the edit template' do
				sign_in
				installation = Installation.create(:customer_id => @customer.id, :name => "Installation", :active => true, :image_url => "http://lufthouseawsbucket.s3.amazonaws.com/beacons/content_images/000/000/178/original/final_scavenger_hunt_6.png?1422037076")
				patch :update, id: @installation.id, customer_id: @user.customer_id, installation: attributes_for(:installation, name: nil)
				expect(response).to render_template :edit 
			end
		end
	end 

	describe 'DELETE destroy' do
		before :each do 
			@delete_installation = FactoryGirl.create(:installation, customer: @customer)
			sign_in
		end

		it 'deletes the installation' do
		
			expect{
				delete :destroy, id: @delete_installation, customer_id: @user.customer_id
			}.to change(Installation,:count).by(-1)

		end

		it 'redirects to installations#index' do
			delete :destroy, id: @delete_installation, customer_id: @user.customer_id
			expect(response).to redirect_to customer_installations_path(:customer_id => @customer.id)
		end

	end

end