class Authentication < ActiveRecord::Base
  #Associations
  	belongs_to :user, inverse_of: :authentications

  #Attributes
  	attr_accessible :provider, :uid, :user_id, :nickname, :token
end
