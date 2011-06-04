require 'spec_helper'

describe Atm do
  describe "#make_wad" do
    before do
      Factory(:bill, :denomination => 20, :units => 5)
      Factory(:bill, :denomination => 100, :units => 4)
    end

    it { Atm.make_wad(80).should   == {20 => 4} }
    it { Atm.make_wad(90).should   == {} }
    it { Atm.make_wad(100).should  == {100 => 1} }
    it { Atm.make_wad(130).should  == {} }
    it { Atm.make_wad(120).should  == {100 => 1, 20 => 1} }
    it { Atm.make_wad(2000).should == {} }
  end

  shared_examples_for "bill inventory" do |amount, expected_inventory|
    before do
      Atm.dispense(amount)
    end
    
    it "has expected inventory" do
      expected_inventory.each do |denomination, units|
        Bill.where(:denomination => denomination).first.units.should == units
      end
    end
  end

  describe "#dispense" do
    before do
      Factory(:bill, :denomination => 20, :units => 5)
      Factory(:bill, :denomination => 100, :units => 4)
    end
    
    it_should_behave_like "bill inventory", 80,   {20 => 1, 100 => 4}
    it_should_behave_like "bill inventory", 120,  {20 => 4, 100 => 3}
    it_should_behave_like "bill inventory", 180,  {20 => 1, 100 => 3}
    it_should_behave_like "bill inventory", 500,  {20 => 0, 100 => 0}
  end
end
