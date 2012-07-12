class Profile < ActiveRecord::Base
  #Associations
  	belongs_to :user, :inverse_of => :profile

  #Attributes
  	attr_accessible :about, :first_name, :last_name, :user_id,  :image, :remote_image_url,
      :updated_at, :created_at, :image_cache, :remove_image
    mount_uploader :image, ImageUploader

  #Callbacks
    before_save { |profile| profile.slug = profile.slug.downcase }

  #Validation
    validates :first_name, :presence => true
    validates :last_name, :presence => true
    validates :user_id, :presence => true

  #Functions
  def full_name=(fullname)
      first,last = fullname.split(' ')  # or some smarter way to split
      self.first_name = first
      self.surname = last
  end


end
