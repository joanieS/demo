require 'rails_helper'

RSpec.describe Customer, :type => :model do
  it "is valid with a name, category, address" do
  	customer = Customer.new(name: 'Example', category: 'Museum', address: '123 Ottawa Avenue North, Minneapolis, Minnesota')
  	expect(customer).to be_valid
  end

  it "is invalid without a name" do
  	expect(Customer.new(name: nil)).to have(1).errors_on(:name)
  end


end
