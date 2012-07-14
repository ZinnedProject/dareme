class Video < ActiveRecord::Base
  #Associations
  	belongs_to :event, inverse_of: :videos

  #Attributes
  	attr_accessible :description, :event_id, :event_video_type, 
  		:is_complete, :title, :yt_video_id

  #Scopes
  	scope :completes,   where(:is_complete => true)
  	scope :incompletes, where(:is_complete => false)
	  scope :request_video,   where(:event_video_type => "request")
	  scope :proof_video,   where(:event_video_type => "proof")

 #require 'youtube_it'
    # client = YouTubeIt::OAuth2Client.new(client_access_token: Authentications., 
    #   client_refresh_token: "refresh_token", 
    #   client_id: "client_id", 
    #   client_secret: "client_secret", 
    #   dev_key: "dev_key", 
    #   expires_at: "expiration time")

 
end
