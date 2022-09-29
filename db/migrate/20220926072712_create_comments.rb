class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.string "commentable_type", null: false
      t.integer "commentable_id", null: false
      t.string "message"

      t.timestamps
    end
  end
end
