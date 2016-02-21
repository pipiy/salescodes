json.array!(@offers) do |offer|
  json.extract! offer, :id, :name, :description, :picture
  json.url offer_url(offer, format: :json)
end
