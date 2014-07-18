json.array!(@installations) do |installation|
  json.extract! installation, :id, :name, :group, :active, :beacons
  json.url installation_url(installation, format: :json)
end
