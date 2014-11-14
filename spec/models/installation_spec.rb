require 'rails_helper'
require 'pry'

RSpec.describe Installation, :type => :model do

  it "has none to begin with" do
  	expect(Installation.count).to eq 0
  end

  it "has one when you add one" do
  	create(:installation)
  	expect(Installation.count).to eq 1
  end

  it "has a valid factory" do
    expect(create(:installation)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:installation, name: nil)).to have(1).errors_on(:name)
  end

  it "adds a default image if missing" do
    installation = create(:installation, image: nil )
    expect(installation.image.url).to eq("/assets/logo_white.png")
  end

end
