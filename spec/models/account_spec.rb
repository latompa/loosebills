require 'spec_helper'

describe Account do
  it { should belong_to :user }
  it { should have_many :withdrawals }

  describe "#sufficient_funds?" do
    before do
      @account = Factory(:account, :balance => 100)
    end
    it { @account.sufficient_funds?(100).should be_true }
    it { @account.sufficient_funds?(101).should_not be_true }
  end
end

