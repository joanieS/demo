json.array!(@installations) do |installation|
  json.extract! installation, :id, :name, :group, :active, :customer_id, :created_at, :updated_at, :beacons
  json.url installation_url(installation, format: :json)
end