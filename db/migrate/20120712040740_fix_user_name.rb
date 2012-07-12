class FixUserName < ActiveRecord::Migration
  def up
   	add_column :profiles, :user_name, :string
  	remove_column :users, :user_name
  	add_index :profiles, :user_name
  
  end

  def down
  	remove_column :profiles, :user_name
  	add_column :users, :user_name, :string
  	add_index :users, :user_name

  end
end
