require 'rails_helper'

RSpec.describe Customer, :type => :model do

  it "has a valid factory" do
    expect(create(:customer)).to be_valid
  end

  it "is invalid without a name" do
  	expect(build(:customer, name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid without an address" do
    expect(build(:customer, address: nil)).to have(1).errors_on(:address)
  end

  it "does not allow duplicate accounts" do 
    create(:customer, name: "Duplicate Museum")
  	expect(build(:customer, name: "Duplicate Museum")).to have(1).errors_on(:name)
	end

  it "provides a latitude based on address" do
    customer = create(:customer)
  	expect(customer.latitude).to_not be_nil
  end

  it "provides a longitude based on address" do
  	customer = create(:customer)
  	expect(customer.longitude).to_not be_nil
  end

end
