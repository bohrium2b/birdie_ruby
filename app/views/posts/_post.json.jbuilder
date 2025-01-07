json.extract! post, :id, :title, :profile_id, :body, :stats, :created_at, :updated_at
json.url post_url(post, format: :json)
