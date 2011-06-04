require 'spec_helper'

describe User do
  it { should validate_presence_of :name }
  it { should have_one :account }
  it { should validate_presence_of :account }
  
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
  
  describe "#failed_logins" do
    let(:user) {Factory(:user, :failed_logins => 1)}
    
    it "resets failed_login" do
      user.valid_pin?("1234")
      user.failed_logins.should == 0
    end
    it "increases failed_login" do 
      user.valid_pin?("7955")
      user.failed_logins.should == 2
    end
  end
  
  describe "#locked_out?" do
    let(:valid_user) {Factory(:user, :failed_logins => 0)}
    let(:locked_user) {Factory(:user, :failed_logins => 3)}
    
    it { valid_user.locked_out?.should_not be_true}
    it { locked_user.locked_out?.should be_true}
    it "won't let a valid PIN to be used" do
      locked_user.valid_pin?("1234").should be_false
    end
  end
  
  describe "#remaining_logins" do
    let(:user1) {Factory(:user, :failed_logins => 0)}
    let(:user2) {Factory(:user, :failed_logins => 2)}
    let(:user3) {Factory(:user, :failed_logins => 10)}
    it {user1.remaining_logins.should == 3}
    it {user2.remaining_logins.should == 1}
    it {user3.remaining_logins.should == 0}
  end
  
  shared_examples_for "valid PIN format" do |pin|
    before do
      @user = Factory.build(:user, :pin => pin) ; @user.save
    end
    it { @user.should have(0).errors_on(:pin) } 
  end
  shared_examples_for "invalid PIN format" do |pin|
    before do
      @user = Factory.build(:user, :pin => pin) ; @user.save
    end
    it { @user.errors[:pin].should include("should be 4 digits") }
  end
  
  describe "PIN formats" do
    it_should_behave_like "valid PIN format", "1234"
    it_should_behave_like "valid PIN format", "7955"
    
    it_should_behave_like "invalid PIN format", "12"
    it_should_behave_like "invalid PIN format", "3214a"
    it_should_behave_like "invalid PIN format", "tl;dr"
    it_should_behave_like "invalid PIN format", ""
    it_should_behave_like "invalid PIN format", nil
  end
  
end
