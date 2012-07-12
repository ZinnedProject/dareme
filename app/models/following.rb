class Following < ActiveRecord::Base

  #Associations
  	belongs_to :user, :inverse_of => :follows
	  belongs_to :followable, polymorphic: true
	  #belongs_to :following, class_name: 'Followable', polymorphic: true

  #Attributes
  	attr_accessible :followable_id, :followable_type, :user_id, :followable, :user_id,
      :created_at, :updated_at, :id

  #Callbacks
    validates_uniqueness_of :user_id, :scope => [:followable_id,:followable_type]

  #Validates
    validates :user_id, :presence => true
    validates :followable_type, :presence => true
    validates :followable_id, :presence => true


end
