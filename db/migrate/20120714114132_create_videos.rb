class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.integer :event_id
      t.string :event_video_type
      t.boolean :is_complete, default: false
      t.text :description
      t.string :yt_video_id

      t.timestamps
    end
    add_index :videos, :event_id
  end
end
