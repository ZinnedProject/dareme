class Event < ActiveRecord::Base
  #Functionality
   #Friendly ID
    extend FriendlyId
    friendly_id :slug
   #Votable
    acts_as_voteable

	#Associations
	  belongs_to :user, :inverse_of => :events
    has_many :comments, :as => :commentable
    
    #@event.followers
    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    #@event.videos
    #has_many :videos, inverse_of: :event 

  #Attributes
    attr_accessible :description, :status, :raise_end, :event_time, :location, :minimum_raise, 
  	 :title, :user_id, :slug, :longitude,:latitude, :created_at, :updated_at,
     :request_video, :proof_video, :image, :remote_image_url, :image_cache, :remove_image

    mount_uploader :image, ImageUploader

  #Callbacks
    before_save { |event| event.slug = event.slug.downcase }
    after_validation :geocoding

  #Scopes
  	scope :default_order, order(:raise_end)
    scope :popular, joins("LEFT JOIN followings ON followings.followable_type = 'Event' AND followings.followable_id = events.id").select("events.*, count(*) as users_following").group("events.id").order("users_following desc")
    scope :open, where(status: 'Open')
    scope :completed, where(status: 'Completed')
    scope :limit_me, limit(100)

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

    def total_vote
      self.votes_for + (self.votes_against*-1)
    end

end



