json.array!(@customers) do |customer|
  json.extract! customer, :name
  json.installation customer.installations, :name, :beacons 	
end