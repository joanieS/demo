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
	end

	it 'should have a current_user' do
		current_user = @user
		current_user.should_not be_nil
	end

	describe "GET #index " do
		it "returns an OK (200) status code" do
			expect(response.status).to eq(200)
		end


	end
	


end