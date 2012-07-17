class AddDefaultToComplete < ActiveRecord::Migration
  def change
  	remove_column :videos, :is_complete
  	add_column :videos, :is_complete, :string, default: false
  end
end
