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
    (!locked_out? && pin_matches?(pin)).tap do |valid|
      if valid
        update_attribute(:failed_logins, 0)
      else
        increment(:failed_logins, 1)
        save
      end
    end
  end
  
  def locked_out? 
    failed_logins >= MAX_LOGINS
  end
  
  def remaining_logins
    (MAX_LOGINS - failed_logins) < 0 ? 0 : (MAX_LOGINS - failed_logins)
  end
  
  private
  def pin_matches?(pin)
    (BCrypt::Engine.hash_secret(pin, self.pin_salt) == self.pin_hash)
  end
end
