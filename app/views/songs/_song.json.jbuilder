json.extract! song, :id, :title, :album, :plays, :created_at, :updated_at
json.url song_url(song, format: :json)
