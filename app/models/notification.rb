class Notification < ActiveRecord::Base
	#Associations
		belongs_to :notifiable, polymorphic: true

  #Attributes
  	attr_accessible :content, :notifiable_id, :notifiable_type, :notifiable
end
