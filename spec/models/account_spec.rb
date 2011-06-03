require 'spec_helper'

describe Account do
  it { should belong_to :user }
  it { should have_many :withdrawals }

  describe "#withdraw" do 
    before do
      @account = Factory(:account, :balance => 100)
    end
    def withdraw(amount)
      @withdrawal = @account.withdraw(amount)
    end

    describe "sufficient funds" do
      it "decreases the balance" do
        expect { withdraw(40) }.to change{ @account.balance }.from(100).to(60)
      end
      it "creates a withdrawal record" do
        expect { withdraw(40) }.to change{ Withdrawal.count }.by(1)
      end
    end

    describe "insufficient funds" do
      it "won't decrease the balance" do
        expect { lambda { withdraw(200) }.should raise_error }.to_not change{ @account.balance }
      end
      it "won't create a withdrawal record" do
        expect { lambda { withdraw(200) }.should raise_error }.to_not change { Withdrawal.count }
      end
    end
  end

  describe "#sufficient_funds?" do
    before do
      @account = Factory(:account, :balance => 100)
    end
    it { @account.sufficient_funds?(100).should be_true }
    it { @account.sufficient_funds?(101).should_not be_true }
  end
end

