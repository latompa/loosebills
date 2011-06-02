class User < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :pin

  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :hash_pin
  
  validates_format_of :pin, :with => /^[0-9]{4}$/, :on => :create, :message => "should be 4 digits"

  def hash_pin
    if pin.present?
      self.pin_salt = BCrypt::Engine.generate_salt  
      self.pin_hash = BCrypt::Engine.hash_secret(pin, self.pin_salt)
    end
  end
  
  def valid_pin?(pin)
    BCrypt::Engine.hash_secret(pin, self.pin_salt) == self.pin_hash
  end

end
