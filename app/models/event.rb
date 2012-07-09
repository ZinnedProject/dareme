class Event < ActiveRecord::Base

	#Associations
	  belongs_to :user, :inverse_of => :events
    has_many :comments, :as => :commentable

  #Attributes
    attr_accessible :description, :raise_end, :event_time, :location, :minimum_raise, 
  	 :title, :user_id, :custom_url, :longitude,:latitude, :created_at, :updated_at

  #Callbacks
    before_save { |event| event.custom_url = event.custom_url.downcase }
    after_validation :geocoding

  #Scopes
  	scope :default_order, order(:raise_end)

  #Validation
  	validates :custom_url, :presence => true
  	validates :custom_url, :format => { :with => /^\w+$/i,
    	:message => "only letters and numbers allowed" }
  	validates :custom_url, :exclusion => {:in => %w(contact dashboard profile 
  			profiles ass dick cunt prick shit fuck connection contacts connections 
  			home edit new create update post push), :message => "Please choose 
				a different user name"} 
  	validates :custom_url, :length => {:maximum => 50, 
  			:too_long => "%{count} characters is the maximum allowed"}
  	validates :custom_url, :length => {:minimum => 4, 
  			:too_short => "%{count} characters is the manimum allowed"}
  	validates :custom_url, :uniqueness => { :case_sensitive => false }
		validates :minimum_raise, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => -1, :less_than => 250}

    validates :description, :presence => true
    validates :raise_end, :presence => true
    validates :event_time, :presence => true
    validates :location, :presence => true
    validates :title, :presence => true
    validates :custom_url, :presence => true
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



end


