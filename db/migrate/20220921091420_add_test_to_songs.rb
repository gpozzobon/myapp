class AddTestToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :test, :string
  end
end
