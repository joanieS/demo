json.array!(@installations) do |installation|
  json.extract! installation, :id, :name, :group, :beacons
  json.url installation_url(installation, format: :json)
end
