class MoveUserSlugToUser < ActiveRecord::Migration
  def up
  	remove_column :profiles, :slug
  	add_column :users, :slug, :string
  	add_index :users, :slug, unique: true
  end

  def down
  	remove_column :users, :slug
  	add_column :profiles, :slug, :string
  	add_index :profiles, :slug, unique: true
  end
end
