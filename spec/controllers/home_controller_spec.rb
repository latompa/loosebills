require 'spec_helper'

describe HomeController do
  
  describe "GET /index" do
    it "should redirect to login if not authenticated" do
      get :index
      response.should be_redirect
    end
    it "should be successful if authenticated" do
      @controller.should_receive(:current_user).and_return(Factory(:user))
      get :index
      response.should be_success
    end
  end
  
end
