class Video < ActiveRecord::Base
  attr_accessible :description, :event_id, :event_video_type, :is_complete, :title, :yt_video_id
end
