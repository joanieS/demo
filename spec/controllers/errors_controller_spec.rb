require 'rails_helper'

RSpec.describe ErrorsController, :type => :controller do

  describe "GET file_not_found" do
    it "returns http success" do
      get :file_not_found
      expect(response).to be_success
    end
  end

  describe "GET unprocessable" do
    it "returns http success" do
      get :unprocessable
      expect(response).to be_success
    end
  end

  describe "GET internal_server_error" do
    it "returns http success" do
      get :internal_server_error
      expect(response).to be_success
    end
  end

end
