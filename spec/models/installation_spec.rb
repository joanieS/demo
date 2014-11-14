require 'rails_helper'
require 'pry'

RSpec.describe Installation, :type => :model do

  it "has none to begin with" do
  	expect(Installation.count).to eq 0
  end

  it "has one when you add one" do
  	installation = Installation.create(name: 'Example', customer_id: 1, image_url: 'http://www.cadillacfaq.com/faq/answers/logos/cadillac.jpg')
  	expect(Installation.count).to eq 1
  end

  it "is valid with a name, customer_id, image" do
  	customer = Customer.create
  	installation = Installation.create(name: 'Example', customer_id: "#{customer.id}", image_url: 'http://www.cadillacfaq.com/faq/answers/logos/cadillac.jpg')
  	expect(installation).to be_valid
  end

  it "is invalid without a name" do
  	expect(Installation.new(name: nil)).to have(1).errors_on(:name)
  end

  it "adds a default image if missing" do
    customer = Customer.create
    installation = Installation.create(name: 'Example', customer_id: "#{customer.id}")
    expect(installation.image.url).to eq("/assets/logo_white.png")
  end

end
