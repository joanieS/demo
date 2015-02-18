require 'rails_helper'
require 'spec_helper'
require 'application_helper'

RSpec.describe ApplicationHelper, :type => :helper do

before :each do
	@customer = FactoryGirl.create(:customer)
	@installation = FactoryGirl.create(:installation, customer: @customer)
	@customer.installations << FactoryGirl.create_list(:installation, 5, customer: @customer)
	@beacon = FactoryGirl.create(:beacon, installation: @installation)
end

	describe "#total_installations(customer)" do
		it "counts the total number of installations" do
			expect(total_installations(@customer)).to eq(@customer.installations.count)
		end
	end

	describe "#total_beacons(customer)" do
		it "counts the total number of beacons for a given customer" do
			expect(total_beacons(@customer)).to eq(@customer.beacons.count)
		end
	end

	describe "#current_state(object)" do
		context "if the object is active" do
			it 'returns the word active' do 
				object = FactoryGirl.create(:beacon, installation: @installation)
				object.active = true
				expect(current_state(object)).to eq("Active")
			end
		end

		context 'if the object is inactive' do
			it 'returns the word inactive' do
				object = FactoryGirl.create(:beacon, installation: @installation)
				object.active = false
				expect(current_state(object)).to eq("Inactive")
			end
		end
	end

	describe '#display_beacon_description(beacon)' do

		context 'if the beacon has a description' do

			it 'returns the description of the beacon' do 
				beacon = FactoryGirl.create(:beacon, description: "This is a beacon")
				expect(helper.display_beacon_description(beacon)).to eq("This is a beacon")

			end
		end

		context 'if the beacon does not have a description' do
			it 'returns the word none' do
				beacon = FactoryGirl.create(:beacon, description: nil)
				expect(helper.display_beacon_description(beacon)).to eq("None.")
			end
		end

	end

	# describe '#sign_in_page(request' do
	# 	context 'if the user is on the sign in page' do
	# 		it 'returns the word hide' do
	# 			request.path_info = "/users/sign_in"
	# 			expect(sign_in_page(request)).to eq(" hide")
	# 		end
	# 	end

	# 	context 'if the user is not on the sign in page' do
	# 		it 'returns nothing' do
	# 		end
	# 	end

	# end

	describe '#check_coordinates(object)' do
		context 'if latitude and longitude are not nil' do
			it 'returns true' do
				customer = FactoryGirl.create(:customer)
				expect(check_coordinates(customer)).to eq(true)
			end
		end

		context 'if latitude or longitude are nil' do
			it 'returns false' do
				customer = FactoryGirl.create(:customer)
				customer.latitude = nil
				expect(check_coordinates(customer)).to eq(false)
			end
		end
	end

	describe '#current_installation(beacon)' do
		it 'finds the installation given a beacon id' do 
			installation = FactoryGirl.create(:installation)
			beacon = FactoryGirl.create(:beacon, :installation_id => installation.id)

			current_installation(beacon)

			expect(@installation.id).to eq (installation.id)
		end
	end


end


#   # Coordinates

#   def set_s3

#     @s3 = AWS::S3.new(
#       :access_key_id => Rails.application.secrets.AWS_ACCESS_KEY_ID,
#       :secret_access_key => Rails.application.secrets.AWS_SECRET_ACCESS_KEY)
#   end

#   def current_installation(beacon)
#     @installation = Installation.find(beacon.installation_id)
#   end

#   def respond_to_destroy(model, name)
#     define_by_name(model, name)
#     respond_to do |format|
#       format.html { redirect_to @destroy_url, notice: "#{name}"+" was successfully destroyed."  }
#       format.json { head :no_content }
#     end
#   end

#   def respond_to_create(model, name)
    
#     respond_to do |format|
#       if model.save
#         successful(model, name, "create", format)
#       else
#         unprocessable(model, :new, format)
#       end
#     end
#   end

#   def respond_to_update(model, name)

#   define_by_name(model, name)
#   set_params(name)

#     respond_to do |format|
#       if model.update(@params_name)
#         successful(model, name, "update", format)
#       else
#         unprocessable(model, :edit, format)
#       end
    
#     end

#   end

#   def define_by_name(model, name)
#     case name
#     when "customer"
#       # @params_name = customer_params
#       @url = @customer
#       @destroy_url = root_path
#     when "installation"
#       # @params_name = installation_params
#       @url = customer_installation_path(@customer, @installation)
#       @destroy_url = customer_installations_path(@customer)
#     when "beacon"
#       # @params_name = beacon_params
#       @url = customer_installation_beacon_path(@customer, @installation, model)
#       @destroy_url = customer_installation_path(@installation, @customer)
#     when "user"
#       # @params_name = user_params
#       @url = users_path
#       @destroy_url = root_path
#     end
#   end

#   def set_params(name)
#     case name
#     when "customer"
#       @params_name = customer_params
#     when "installation"
#       @params_name = installation_params
#     when "beacon"
#       @params_name = beacon_params
#     when "user"
#       @params_name = user_params
#     end
#   end

#   def unprocessable(model, action, format)
#     format.html { render action }
#     format.json { render json: model.errors, status: :unprocessable_entity }
#   end

#   def successful(model, name, result, format)
#     define_by_name(model, name)
#     set_params(name)
#     if result == "create" && model == @customer
#       current_user.update(customer_id: @customer.id)
#     end
#     format.html { redirect_to @url, notice: "#{name}" +" was successfully " +"#{result}"+"ed." }
#     format.json { render :show, status: :created, location: @url }
#   end

#   # Paths

#     # Installation paths
#     def installation_path(installation)
#       customer_installation_path(@customer, installation)
#     end

#     def installations_path(customer)
#       customer_installations_path(@customer)
#     end

#     def new_installation_path
#       new_customer_installation_path(@customer)
#     end

#     def edit_installation_path(installation)
#       edit_customer_installation_path(@customer, installation)
#     end

#     # Beacon paths
#     def beacon_path(beacon)
#       customer_installation_beacon_path(@customer, @installation, beacon)
#     end

#     def new_beacon_path
#       new_customer_installation_beacon_path(@customer, @installation)
#     end

#     def edit_beacon_path(beacon)
#       edit_customer_installation_beacon_path(@customer, @installation, beacon)
#     end

#     # Audio clip paths
#     def audio_clip_path(audio_clip)
#       customer_installation_beacon_path(@customer, @installation, @beacon, audio_clip)
#     end

# end


#   def sign_in_page?(request)
#     request.path_info == "/users/sign_in" ? " hide" : ""
#   end

#   def sign_up_page?(request)
#     request.path_info == "/users/sign_up" ? " hide" : ""
#   end

#   def current_class_about?(request)
#     request.path_info == "/" ? "current" : ""
#   end

#   def current_class_installations?(request)
#     request.path_info =~ /customers+\/[0-9]+\/installations(\/[A-Za-z0-9\/]+)?/ ? "current" : ""
#   end

#   def current_class_account?(request)
#     request.path_info =~ /customers\/[0-9]+(\/edit)?$/ ? "current" : ""
#   end

#   def current_class_new_customer?(request)
#     request.path_info =~ /customers\/new$/ ? "current" : ""
#   end

#   def current_class_existing_customer?(request)
#     request.path_info =~ /users\/[0-9]+\/edit$/ ? "current" : ""
#   end

#   def current_page_installation?(request)
#     request.path_info =~ /customers+\/[0-9]+\/installations\/([0-9]+(\/edit)?|new)$/ ? true : false    
#   end

#   def current_page_metrics?(request)
#     request.path_info == "/metrics" ? "current" : ""
#   end

#   def current_page_beacon?(request)
#     if (request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/beacons\/([0-9]+|new)$/) || (request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/edit$/)
#       true 
#     else
#       false
#     end    
#   end

#   def current_page_beacon_edit?(request)
#     request.path_info =~ /customers+\/[0-9]+\/installations\/[0-9]+\/beacons\/[0-9]+\/edit$/ ? true : false    
#   end
