class Following < ActiveRecord::Base

  #Associations
  	#belongs_to :user #, :inverse_of => :followings
  	#belongs_to :follows, class_name: :user
  	belongs_to :user, :inverse_of => :follows
#  	belongs_to :follows

	  belongs_to :followable, polymorphic: true

  #Attributes
  	attr_accessible :followable_id, :followable_type, :user_id
  

end
