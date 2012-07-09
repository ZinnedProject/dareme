class RenamecolumnfromIdtoUserId < ActiveRecord::Migration
  def change
  		rename_column :comments, :from_id, :user_id
  end

end
