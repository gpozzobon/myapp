class CreateAuthorsSongsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :authors, :songs
  end
end
