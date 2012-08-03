class Event < ActiveRecord::Base
  #Functionality
   #Friendly ID
    extend FriendlyId
    friendly_id :slug

   #Votable
    acts_as_voteable

   #PG Full Text Searching
    include PgSearch

   #multisearchable :against => [:title, :location, :description]
    pg_search_scope :event_search, 
      against: {:title => 'A',:location => 'B',:description => 'C'},
      using: {tsearch: {dictionary: "english", :prefix => true}}
      #http://railscasts.com/episodes/343-full-text-search-in-postgresql

	#Associations
	  belongs_to :user, :inverse_of => :events
    has_many :comments, :as => :commentable
    
    #@event.followers
    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    #@events.notifications
    has_many :notifications, as: :notifiable, dependent: :destroy

  #Attributes
    attr_accessible :description, :status, :raise_end, :event_time, :location, :minimum_raise, 
  	 :title, :user_id, :slug, :longitude,:latitude, :created_at, :updated_at,
     :request_video, :proof_video, :image, :remote_image_url, :image_cache, :remove_image

    mount_uploader :image, ImageUploader
  #Delayed Job Processing
    process_in_background :image


  #Callbacks
    before_save { |event| event.slug = event.slug.downcase }
    after_validation :geocoding
    after_update :create_notifications

  #Scopes
  	scope :default_order, order(:raise_end)
    scope :popular, joins("LEFT JOIN followings ON followings.followable_type = 'Event' AND followings.followable_id = events.id").select("events.*, count(*) as users_following").group("events.id").order("users_following desc")
    scope :status_open, where(status: 'Open')
    scope :status_completed, where(status: 'Completed')
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
        geocode.delay
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

    #Full Text Search
    def self.text_search(query)
      if query.present?
        event_search(query).limit_me
      else 
        scoped
      end
    end

    def create_notifications
      content = Array.new
      content << " has changed its location to " + self.location if location_changed?
      content << " has changed its description.. you may want to check it out" if description_changed?
      content << " is the new name of the event." if title_changed?
      content << " has changed its event time.  Don't be late." if event_time_changed?
      content << " has a new sweet image.  Check it out." if image_changed?

   
      if content.count > 1
        Notification.create(content:" was was just updated.  A lot.  Review it now!" , notifiable: self) 
      elsif content.count == 1
        Notification.create(content: content[0], notifiable: self) 
      end
      
      if status_changed?
        if self.status == 'Completed'
          content = " has just been completed.  Check it out now!  It's some crazy sh*t."         
          Notification.create(content: content, notifiable: self) 
        end
      end
    end

end



