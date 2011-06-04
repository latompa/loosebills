require 'spec_helper'

describe Withdrawal do
  it { should belong_to :account }
  it { should validate_numericality_of :amount }
    
  describe "create" do 
    before do
      @account = Factory(:account, :balance => 100)
    end
    
    describe "sufficient funds" do
      before do
        @bill = Factory(:bill, :denomination => 20, :units => 5)
      end
      
      it "decreases the balance" do
        expect { withdraw(40) }.to change{ Account.find(@account.id).balance }.from(100).to(60)
      end
      it "creates a withdrawal record" do
        expect { withdraw(40) }.to change{ Withdrawal.count }.by(1)
      end
      it "decreases the bills in the atm" do
        expect { withdraw(40) }.to change{ Bill.denomination(20).first.units }.by(-2)
      end
      it "saves the dispensed bills as an hash" do
        withdraw(40).bills.should == {20 => 2}
      end
    end

    describe "insufficient funds" do
      before do
        @bill = Factory(:bill, :denomination => 20, :units => 10)
      end
      
      it "won't decrease the balance" do
        expect { withdraw(200) }.to_not change{ Account.find(@account.id).balance }
      end
      it "won't create a withdrawal record" do
        expect { withdraw(200) }.to_not change { Withdrawal.count }
      end
      it "won't decrease the bills in the atm" do
        expect { withdraw(200) }.to_not change{ Bill.denomination(20).first.units }
      end
      it {withdraw(200).errors[:base].should include("Not enough funds on account")}
    end
    
    describe "insufficient bills" do
      before do
        @bill = Factory(:bill, :denomination => 20, :units => 1)
      end
      
      it "won't decrease the balance" do
        expect { withdraw(100) }.to_not change{ Account.find(@account.id).balance }
      end
      it "won't create a withdrawal record" do
        expect { withdraw(100) }.to_not change { Withdrawal.count }
      end
      it "won't decrease the bills in the atm" do
        expect { withdraw(100) }.to_not change{ Bill.denomination(20).first.units }
      end
      it {withdraw(100).errors[:base].should include("No bills available")}
    end
  end
  
  def withdraw(amount)
    @withdrawal = @account.withdrawals.create :amount => amount
  end
end
