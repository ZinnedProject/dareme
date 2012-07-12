class AddUserNametoUser < ActiveRecord::Migration
  def change
  	remove_column :profiles, :user_name
  	add_column :users, :user_name, :string
  	add_index :users, :user_name
  end


end
