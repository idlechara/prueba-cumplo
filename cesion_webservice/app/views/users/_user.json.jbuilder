json.extract! user, :id, :username, :certificate, :private_key, :created_at, :updated_at
json.url user_url(user, format: :json)
