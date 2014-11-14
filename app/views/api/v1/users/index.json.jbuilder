json.array!(@users) do |user|
  json.extract! user, :id, :show, :new, :create, :edit, :update, :destroy
  json.url user_url(user, format: :json)
end
