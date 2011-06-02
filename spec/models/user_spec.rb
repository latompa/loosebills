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
