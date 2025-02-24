json.extract! post, :id, :en_post, :ko_post, :tags, :category, :featured, :archive, :priority, :approved, :created_at, :updated_at
json.url post_url(post, format: :json)
