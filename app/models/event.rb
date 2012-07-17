class Event < ActiveRecord::Base
  #Functionality for friendly IDs
    extend FriendlyId
    friendly_id :slug

	#Associations
	  belongs_to :user, :inverse_of => :events
    has_many :comments, :as => :commentable
    
    #@event.followers
    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    #@event.videos
    has_many :videos, inverse_of: :event 

  #Attributes
    attr_accessible :description, :raise_end, :event_time, :location, :minimum_raise, 
  	 :title, :user_id, :slug, :longitude,:latitude, :created_at, :updated_at,
     :request_video, :proof_video, :image, :remote_image_url

    mount_uploader :image, ImageUploader

  #Callbacks
    before_save { |event| event.slug = event.slug.downcase }
    after_validation :geocoding

  #Scopes
  	scope :default_order, order(:raise_end)

  #Validation
  	validates :slug, :presence => true
  	validates :slug, :format => { :with => /^\w+$/i,
    	:message => "only letters and numbers allowed" }
  	validates :slug, :exclusion => {:in => %w(contact dashboard profile 
  			profiles ass dick cunt prick shit fuck connection contacts connections 
  			home edit new create update post push), :message => "Please choose 
				a different user name"} 
  	validates :slug, :length => {:maximum => 50, 
  			:too_long => "%{count} characters is the maximum allowed"}
  	validates :slug, :length => {:minimum => 4, 
  			:too_short => "%{count} characters is the manimum allowed"}
  	validates :slug, :uniqueness => { :case_sensitive => false }
		validates :minimum_raise, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => -1, :less_than => 250}

    validates :description, :presence => true
    validates :raise_end, :presence => true
    validates :event_time, :presence => true
    validates :location, :presence => true
    validates :title, :presence => true
    validates :slug, :presence => true
    validates :user_id, :presence => true

  #Other
    geocoded_by :location

  #Functions

    def geocoding
      if location_changed? and not location.nil? and not Rails.env.test? and not location.empty?
        geocode
      else
        false
      end
    end


  def self.yt_session
#    puts self.to_yaml
#    auth = user.authentications.youtube
    #puts "------------_>AUTH"
    #puts auth.to_yaml

  end



end



