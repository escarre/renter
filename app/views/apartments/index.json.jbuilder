json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :name, :address, :lease_start, :lease_end, :description, :user_id
  json.url apartment_url(apartment, format: :json)
end
