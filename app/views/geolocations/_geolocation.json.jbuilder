json.extract! geolocation, :id, :name, :latitude, :longitude, :created_at, :updated_at
json.url geolocation_url(geolocation, format: :json)
