json.array!(@beacons) do |beacon|
  json.extract! beacon, :id, :minor_id, :major_id, :latitude, :longitude, :content, :type, :audio, :installation_id
  json.url beacon_url(beacon, format: :json)
end
