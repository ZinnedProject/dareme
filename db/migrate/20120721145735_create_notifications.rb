class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :content
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps
    end
    add_index :notifications, :notifiable_id
		add_index :notifications, :notifiable_type
  end
end

