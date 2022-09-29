class DeleteAuthorsSongs < ActiveRecord::Migration[6.1]
  def change
    drop_table :author_songs
  end
end
