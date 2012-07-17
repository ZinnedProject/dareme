class RemoveVideos < ActiveRecord::Migration
  def up
	drop_table :videos
	add_column :events, :request_video, :string
	add_column :events, :proof_video, :string

  end

end
