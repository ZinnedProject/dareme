class ChangeVideosToAddingToEventDirectly < ActiveRecord::Migration
  def change
  	drop_table :videos

  	add_column :events, :rv_title, :string
  	add_column :events, :rv_is_complete, :boolean
  	add_column :events, :rv_description, :text
  	add_column :events, :rv_keywords, :text
  	add_column :events, :rv_yt_video_id, :string

  	add_column :events, :pv_title, :string
  	add_column :events, :pv_is_complete, :boolean
  	add_column :events, :pv_description, :text
  	add_column :events, :pv_keywords, :text
  	add_column :events, :pv_yt_video_id, :string
  end


end
