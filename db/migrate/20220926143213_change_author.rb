class ChangeAuthor < ActiveRecord::Migration[6.1]
  def change
    remove_column :songs, :author
  end
end
