class Comment < ActiveRecord::Base
	#Associations
  	belongs_to :imageable, :polymorphic => true

  #Associations
  	belongs_to :user, :inverse_of => :comments

  #Attributes
  	attr_accessible :content, :commentable_id, :commentable_type, :user_id

end
