class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :event_time
      t.string :title
      t.string :location
      t.decimal :minimum_raise
      t.integer :duration
      t.text :description
      t.string :custom_url
      
      t.timestamps
    end
  add_index :events, :user_id
  add_index :events, :custom_url
  end
end
