require 'spec_helper'

describe User do
  it { should validate_presence_of :name }
  
  describe "name uniqueness" do
    before { Factory(:user) }
    
    it "won't allow another user with same name" do
      Factory.build(:user).should_not be_valid
    end
  end
  
  describe "PIN storage" do
    let(:user) {Factory(:user, :pin => "1234")}
    
    it "saves the PIN hash" do
      user.pin_hash.should be_present
    end
    it "saves the PIN salt" do
      user.pin_salt.should be_present
    end
  end

  describe "#valid_pin?" do
    let(:user) {Factory(:user, :pin => "1234")}
    
    it "authenticates with correct PIN" do
      user.valid_pin?("1234").should be_true
    end
    it "doesn't authenticate with incorrect PIN" do
      user.valid_pin?("4321").should_not be_true
    end
  end
  
end
