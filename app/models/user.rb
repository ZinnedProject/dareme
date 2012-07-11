class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations (Remove DD for all associations.  Destory = inactivate)
		has_one :profile, :inverse_of => :user, :dependent => :destroy
    has_many :events, :inverse_of => :user, :dependent => :destroy

    has_many :comments, :inverse_of => :user, :dependent => :destroy

    #user.follows
    has_many :follows, class_name: 'Following', foreign_key: "user_id", inverse_of: :user
    has_many :followed_events, through: :follows, source: :followable, source_type: 'Event'
    has_many :followed_users, through: :follows, source: :followable, source_type: 'User'

    #user.followers
    has_many :followings, :as => :followable
    has_many :followers, :through => :followings, :source => :user

  #Attributes
  	attr_accessible :email, :password, :password_confirmation, :remember_me

  #Callbacks
    after_create :create_profile

  def create_profile  #When a user is created make sure a profile is created for them as well
    profile = Profile.new
    profile.user_id = id
    profile.user_name = "newuser" + (id+12000).to_s()
    profile.save(validate: false)
  end

end
