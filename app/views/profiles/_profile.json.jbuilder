json.extract! profile, :id, :user_id, :handle, :ispublic, :bio, :gender, :created_at, :updated_at
json.url profile_url(profile, format: :json)
