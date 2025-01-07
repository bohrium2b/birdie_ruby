json.extract! profile, :id, :user_id, :ispublic, :bio, :created_at, :updated_at
json.url profile_url(profile, format: :json)
