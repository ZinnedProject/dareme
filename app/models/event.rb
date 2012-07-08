class Event < ActiveRecord::Base

	#Associations
	belongs_to :user, :inverse_of => :events
	has_many :albums, :as => :albumable, :dependent => :destroy

  #Attributes
  attr_accessible :description, :raise_end, :event_time, :location, :minimum_raise, 
  	:title, :user_id, :custom_url

  #Callbacks
    before_save { |event| event.custom_url = event.custom_url.downcase }
    after_create :create_album

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

  def create_album  #When a user is created make sure an album is created for them as well
    album = Album.new
    album.albumable = self
    album.title ="Even Photos"
    album.save
  end

end
