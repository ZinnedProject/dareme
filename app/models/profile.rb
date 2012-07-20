class Profile < ActiveRecord::Base
  #Associations
  	belongs_to :user, :inverse_of => :profile

  #Attributes
  	attr_accessible :about, :first_name, :last_name, :user_id,  :image, :remote_image_url,
      :updated_at, :created_at, :image_cache, :remove_image, :location, :latitude, :longitude

    mount_uploader :image, ImageUploader

  #Call Backs
    after_validation :geocoding

  #Validation
    validates :first_name, :presence => true
    validates :last_name, :presence => true
    validates :user_id, :presence => true
  #Other
    geocoded_by :location

  #Functions
  def geocoding
    if location_changed? and not location.nil? and not Rails.env.test? and not location.empty?
      geocode
    else
      false
    end
  end

  def full_name=(fullname)
      first,last = fullname.split(' ')  # or some smarter way to split
      self.first_name = first
      self.surname = last
  end


end
