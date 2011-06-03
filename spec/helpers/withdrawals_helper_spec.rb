require 'spec_helper'

describe WithdrawalsHelper do
  describe "#sufficient_funds?" do
    before do
      helper.stub!(:current_user).and_return(Factory(:user))
    end
    it "returns true if sufficient funds" do
      helper.sufficient_funds?(100)
    end
  end
end
