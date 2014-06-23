json.array!(@installations) do |installation|
  json.extract! installation, :id, :name, :group, :customer_id
  json.url installation_url(installation, format: :json)
end
