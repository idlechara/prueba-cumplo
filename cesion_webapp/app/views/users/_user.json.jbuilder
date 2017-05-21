json.extract! user, :id, :username, :password, :certificate, :private_key, :rut, :created_at, :updated_at
json.url user_url(user, format: :json)
