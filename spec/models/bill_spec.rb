require 'spec_helper'

describe Bill do
  it { should ensure_inclusion_of(:denomination).in_range([20, 100]) }
  it { should validate_numericality_of(:units) }
  
  before do
    @twenty =  Factory(:bill, :denomination => 20, :units => 5)
    @hundred = Factory(:bill, :denomination => 100, :units => 4)
  end
  
  describe ".bills_available?" do
    it { Bill.available?(20, 20).should be_true }
    it { Bill.available?(20, 100).should be_true }
    it { Bill.available?(20, 120).should_not be_true }
    it { Bill.available?(100, 120).should be_true }
    it { Bill.available?(100, 520).should_not be_true }
  end
  
  describe ".get_as_many_as_possible" do
    it { Bill.get_as_many_as_possible(100,400).should == 4 }
    it { Bill.get_as_many_as_possible(100,1000).should == 4 }
  end
  
  describe "#take" do 
    it { expect { @twenty.take(4) }.to change{@twenty.units }.from(5).to(1) }
    it { expect { lambda { @twenty.take(6) }.should raise_error}.to_not change{@twenty.units} }
  end
end
