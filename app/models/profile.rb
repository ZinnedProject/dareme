class Profile < ActiveRecord::Base
  #Associations
  	belongs_to :user, :inverse_of => :profile

  #Attributes
  	attr_accessible :about, :first_name, :last_name, :user_id, :user_name

  #Callbacks
    before_save { |profile| profile.user_name = profile.user_name.downcase }

  #Validation
  	validates :user_name, :presence => true
  	validates :user_name, :format => { :with => /^\w+$/i,
    	:message => "only letters and numbers allowed" }
  	validates :user_name, :exclusion => {:in => %w(contact dashboard profile 
  			profiles ass dick cunt prick shit fuck connection contacts connections 
  			home edit new create update post push), :message => "Please choose 
				a different user name"} 
  	validates :user_name, :length => {:maximum => 50, :too_long => "%{count} characters is the maximum allowed"}
  	validates :user_name, :length => {:minimum => 4, :too_short => "%{count} characters is the manimum allowed"}
  	validates :user_name, :uniqueness => { :case_sensitive => false }

  

  #Functions
  def full_name=(fullname)
      first,last = fullname.split(' ')  # or some smarter way to split
      self.first_name = first
      self.surname = last
  end


end
