class Bill < ActiveRecord::Base
  validates_inclusion_of :denomination, :in => [20, 100]
  validates_numericality_of :units, :greater_or_equal_than => 0
  validates_uniqueness_of :denomination
  
  scope :by_highest_denomination, :order => "denomination DESC"
  scope :denomination, lambda {|denomination| where(:denomination => denomination) }

  def take(requested_units)
    raise "can't take #{requested_units} of #{self.denomination}, only #{units} available" if requested_units > units 
    self.units -= requested_units
    save
  end
      
  def self.available?(denomination, amount)
    bills = Bill.where(:denomination => denomination).first
    if bills
      (bills.denomination * bills.units) >= amount
    else
      false
    end
  end
    
  def self.get_as_many_as_possible(denomination, amount)
    requested_units = amount / denomination
    available_units = Bill.denomination(denomination).first.units
    requested_units < available_units ? requested_units : available_units
  end
end
