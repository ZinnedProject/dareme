class AddNickNameToAuthentications < ActiveRecord::Migration
  def change
  	add_column :authentications, :nickname, :string
  	add_column :authentications, :token, :string
  end
end
