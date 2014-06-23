json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :category
  json.url customer_url(customer, format: :json)
end
