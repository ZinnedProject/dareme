class Authentication < ActiveRecord::Base
  #Associations
  	belongs_to :user

  #Attributes
  	attr_accessible :provider, :uid, :user_id
end
