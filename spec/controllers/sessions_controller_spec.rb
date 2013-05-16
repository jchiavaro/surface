require 'spec_helper'

describe SessionsController do

  describe "GET 'login with an existing user'" do
    before do
      @user_attrs = {
        "id" => "1",
        "first_name"=> "some",
        "last_name"=> "admin",
        "email" =>"admin@admin.com",
        "password" =>"administrator",
        active: true
      }
      @user = mock('User', @user_attrs)
    end

    it "should loging the user into the system" do
      get :login_attempt, :user => @user_attrs
      response.should redirect_to(dashboard_user_path :id => @user.id)
    end
  end

  describe "GET 'login with an non existing user'" do
    before do
      @user_attrs = {
        "id" => "1",
        "first_name"=> "some",
        "last_name"=> "some",
        "email" =>"some@user.com",
        "password" =>"bad password"
      }
      @user = mock('User', @user_attrs)
    end

    it "should not loging the user into the system and redirect to the root_path" do
      get :login_attempt, :user => @user_attrs
      response.should redirect_to(root_path)
      flash[:error].should_not be_nil
    end
  end

  describe "#logout" do
    it "should remove the user from the session" do
      get :logout
      session[:user_id].should be_nil
    end
  end
end

