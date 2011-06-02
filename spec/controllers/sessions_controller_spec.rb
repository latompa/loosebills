require 'spec_helper'

describe SessionsController do

  describe "POST create" do
    let(:user) { Factory(:user, :pin => "1234") }
    
    describe "successful" do
      it "adds user_id to session" do
        post :create, {:name => user.name, :pin => "1234"}
        session[:user_id].should == user.id
      end
    end
    describe "unsuccessful" do
      let(:user) { Factory(:user, :pin => "1234") }
      it "won't add user_id to session" do
        post :create, {:name => user.name, :pin => "4321"}
        session[:user_id].should be_nil
      end
    end
  end
  
  describe "GET logout" do
    before do
      @controller.session[:user_id] = Factory(:user)
    end
    it "removes the user_id from the session" do
      get :destroy
      response.should be_redirect
      @controller.session[:user_id].should_not be_present
    end
  end
  
end
