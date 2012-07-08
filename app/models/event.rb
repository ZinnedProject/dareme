class Event < ActiveRecord::Base

	#Associations
	belongs_to :user, :inverse_of => :events

  #Attributes
  attr_accessible :description, :duration, :event_time, :location, :minimum, 
  	:title, :user_id, :custom_url



end
