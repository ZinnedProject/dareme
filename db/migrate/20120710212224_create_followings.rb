class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :followable_id
      t.string  :followable_type

      t.timestamps
    end
    add_index :followings, :followable_type
    add_index :followings, :followable_id
  end
end
