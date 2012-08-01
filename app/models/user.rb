class User < ActiveRecord::Base
  #Functionality 
   #Friendly IDs
    extend FriendlyId
    friendly_id :slug
   #Acts as votable
    acts_as_voter
    has_karma(:events, :as => :submitter, :weight => 0.5)


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations (Remove DD for all associations.  Destory = inactivate)
		has_one :profile, :inverse_of => :user, :dependent => :destroy
    has_many :events, :inverse_of => :user, :dependent => :destroy

    #user.commentsUserMade
    has_many :comments_made, class_name: 'Comment', foreign_key: "user_id", inverse_of: :user
    
    #user.commentsReceived
    has_many :comments, :as => :commentable
    has_many :comments_senders, :through => :comments, :source => :user

    #user.follows
    has_many :follows, class_name: 'Following', foreign_key: "user_id", inverse_of: :user
    has_many :followed_events, through: :follows, source: :followable, source_type: 'Event'
    has_many :followed_users, through: :follows, source: :followable, source_type: 'User'

    #user.followers
    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

    #user.authentications
    has_many :authentications, inverse_of: :user, :dependent => :destroy

  #Attributes
  	attr_accessible :email, :password, :password_confirmation, :remember_me, :slug, :admin

  #Callbacks
    after_create :create_profile
    after_save { |user| user.slug = 'newuser' + (id+12000).to_s }

  #Validations
    validates :slug, :presence => true
    validates :slug, :format => { :with => /^\w+$/i,
      :message => "only letters and numbers allowed" }
    validates :slug, :exclusion => {:in => %w(contact dashboard profile 
        profiles ass dick cunt prick shit fuck connection contacts connections 
        home edit new create update post push), :message => "Please choose 
        a different user name"} 
    validates :slug, :length => {:maximum => 50, :too_long => "%{count} characters is the maximum allowed"}
    validates :slug, :length => {:minimum => 4, :too_short => "%{count} characters is the manimum allowed"}
    validates :slug, :uniqueness => { :case_sensitive => false, message: "has already been taken"}

  def create_profile  #When a user is created make sure a profile is created for them as well
    profile = Profile.new
    profile.user_id = id
    profile.save(validate: false)
  end


  def self.from_omniauth(auth)
    authentication = Authentication.where(auth.slice(:provider, :uid)).first

    if authentication
      user = User.find(authentication.user_id)
    else
      user = User.create(slug: auth.info.nickname, email: auth.info.email)
    end
  end

  def self.new_with_session(params, session) 
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.email = session["devise.omniauth_attributes"].email
        user.valid?
        user.save
        Authentication.create(nickname:session["devise.omniauth_attributes"].nickname,  
              user_id: user.id, 
              provider: session["devise.omniauth_attributes"].provider, 
              uid: session["devise.omniauth_attributes"].uid) if user.valid?
      end     
    else
      super
    end
  end

end # End Class


