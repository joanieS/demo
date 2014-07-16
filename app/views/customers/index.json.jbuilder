json.array!(@customers) do |customer|
  json.extract! customer, :name, :category
  json.installation customer.installations, :name, :beacons 	
end