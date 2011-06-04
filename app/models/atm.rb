class Atm

  cattr_accessor :withdrawal_choices
  @@withdrawal_choices = [20, 40, 80, 100, 120]
  
  def self.bills_available?(amount_requested)
    Bill.all.find do |bill|
      (bill.denomination * bill.units) >= amount_requested 
    end
  end

  #
  # attempt to dispense cash in highest denominations first (vegas style)
  # return wad as a hash denomination => units
  #  for example $180 is {20 => 4, 100 => 1}
  #  if bills aren't available, an empty hash is returned
  #
  def self.make_wad(amount)
    result = Bill.by_highest_denomination.inject({}) do |set_of_bills, bill|
      units = Bill.get_as_many_as_possible(bill.denomination, amount)
      amount -= units * bill.denomination

      set_of_bills[bill.denomination] = units unless (units == 0)
      set_of_bills
    end
    amount == 0 ? result : {}
  end

  def self.dispense(amount)
    wad = Atm.make_wad(amount)
    unless wad.empty?
      wad.each do |denomination, units|
        Bill.denomination(denomination).first.take(units)
      end
    end
  end

end
