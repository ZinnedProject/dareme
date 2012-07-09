class Comment < ActiveRecord::Base
	#Associations
  	belongs_to :imageable, :polymorphic => true
  	belongs_to :user, :inverse_of => :comments

  #Attributes
  	attr_accessible :content, :commentable_id, :commentable_type, :user_id

  #Callback
  	#after_save {|c| if c.content.nil? then c.destroy end}
  		 #before_save { |profile| profile.user_name = profile.user_name.downcase }

  #Scope
		default_scope :order => 'created_at desc'  	

	#Validation
		validates :content, :presence => true
		validates :content, :length => {:maximum => 5000, 
  		:too_long => "%{count} characters is the maximum allowed"}


end
