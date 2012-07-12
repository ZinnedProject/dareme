class AddUniqueIdIndextoFollowings < ActiveRecord::Migration
  def up
  	add_index :followings, [:user_id, :followable_id,:followable_type], unique: true, name: "index_followings_on_all"
  end

  def down
  	remove_index :followings, "index_followings_on_all"
  end



end
