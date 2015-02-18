require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, :type => :controller do

	before :each do 
		@customer = FactoryGirl.create(:customer)
		@installation = FactoryGirl.create(:installation, customer: @customer)
		@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
		@beacon = FactoryGirl.create(:beacon, installation: @installation)
		@user = FactoryGirl.create(:user, customer: @customer)
		sign_in(user = @user)
		current_user = @user
	end

describe "GET #index" do

	context 'without login' do
		it 'blocks access' do
			sign_in nil

			get :index
			response.should_not be_success
		end
	end

	context 'with authenticated access' do

		it 'assigns the current user to current_user' do
			user = FactoryGirl.create(:user, customer: @customer)
			get :edit, id: user
			expect(assigns(:user)).to eq user
		end

		context 'json format requested' do

			it 'renders an index page' do

				get :index, :format => :json
				expect(response).to render_template("index")
			end

		end


	end

end


describe "GET #edit" do

	it 'assigns the requested user to @user' do

		get :edit, id: @user
		expect(assigns(:user)).to eq(@user)

	end

	it 'renders the edit template' do

		get :edit, id: @user
		expect(response).to render_template :edit

	end

end

describe "PATCH #update" do

	context 'with valid attributes' do

		it 'locates the requested customer' do
			patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
			expect(assigns(:user)).to eq(@user)
		end

		it 'updates the requested customer' do
			patch :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: "Sally")
			@user.reload
			expect(@user.first_name).to eq("Sally")
		end

		it 'redirects to the updated user' do
			patch :update, id: @user, user: FactoryGirl.attributes_for(:user)
			expect(response).to redirect_to(customer_path(@user.customer_id))

		end

	end

	context 'with invalid attributes' do

		it 'does not change the user attributes' do
			patch :update, id: @user, user: FactoryGirl.attributes_for(:user, email: nil)
			expect(@user.email).to_not be nil
		end

		it 're-renders the edit template' do
			patch :update, id: @user, user: FactoryGirl.attributes_for(:user, email: nil)
			expect(response).to render_template :edit 
		end
	end

end



describe "DELETE #destroy" do
	before :each do
		@delete_user = FactoryGirl.create(:user)
		sign_in(user = @delete_user)
		current_user = @delete_user
	end

	it 'deletes the user' do
		sign_in(user = @delete_user)
		expect{
			delete :destroy, id: @delete_user
		}.to change(User, :count).by(-1)

	end

	it 'redirects to the root_path' do


	end

end


end
