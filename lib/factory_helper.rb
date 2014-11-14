module FactoryHelper
  def self.full_address
    "#{Faker::Address.street_address}, #{Faker::Address.city} #{Faker::Address.zip}"
  end
end