json.extract! board, :id, :en_post, :ko_post, :tags, :category, :featured, :archive, :priority, :approved, :created_at, :updated_at
json.url board_url(board, format: :json)
