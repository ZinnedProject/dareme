class ChangeFieldType < ActiveRecord::Migration
  def up
  	remove_column :events, :event_time
  	add_column :events, :event_time, :datetime

  	remove_column :events, :duration
  	add_column :events, :raise_end, :datetime
  
  end

  def down
    	
  end
end
