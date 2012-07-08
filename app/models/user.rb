class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations
		has_one :profile, :inverse_of => :user, :dependent => :destroy
    has_many :events, :inverse_of => :user, :dependent => :destroy

  #Attributes
  	attr_accessible :email, :password, :password_confirmation, :remember_me

  #Callbacks
    after_create :create_profile


  def create_profile  #When a user is created make sure a profile is created for them as well
    #debugger
    profile = Profile.new
    profile.user_id = id
    profile.user_name = "newuser" + (id+12000).to_s()
    profile.save
  end



end
