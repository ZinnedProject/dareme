class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id
      t.text :about
      t.string :user_name
      t.timestamps
    end
    add_index :profiles, :user_id
    add_index :profiles, :user_name
  end
end
