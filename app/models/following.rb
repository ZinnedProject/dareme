class Following < ActiveRecord::Base

  #Associations
  	belongs_to :user, :inverse_of => :follows
	  belongs_to :followable, polymorphic: true
	  #belongs_to :following, class_name: 'Followable', polymorphic: true

  #Attributes
  	attr_accessible :followable_id, :followable_type, :user_id, :followable
  
  #Validates
    validates :user_id, :presence => true
    validates :followable_type, :presence => true
    validates :followable_id, :presence => true


end
