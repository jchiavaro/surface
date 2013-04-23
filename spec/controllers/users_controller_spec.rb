require "spec_helper"

describe UsersController do
  describe "#create" do
    before do
      @user_attrs = {
        "id" =>  "1",
        "first_name"=> "juan",
        "last_name"=> "smith",
        "email" =>"js@domain.com",
        "password" =>"some_pass",
        "confirmation_password"=> "some_pass",
        "birthday" =>"1987-12-21",
        "gender" =>"Male"
      }
      @user = mock('User', @user_attrs)
      @mail_message = mock('Mail::Message', {to: "dd@domain.com"})
      User.should_receive(:new).with(@user_attrs).and_return(@user)
      @user.should_receive(:save).and_return(@user)
      post :create, :user => @user_attrs
    end

    it "should register the user" do
      response.should redirect_to(user_dashboard_path @user)
    end

    it "should make the user available for the next view" do
      assigns(:user).should eq(@user)
    end

    it "should save the user id in the session" do
      session[:user_id].should eq(@user.id)
    end

    it "should send a welcome email" do
      welcome_email = ActionMailer::Base.deliveries.last
      assert_equal @user.email, welcome_email.to[0]
    end

    describe "invalid user" do
      before do
        @invalid_user_attrs = {
          "first_name" => "",
          "password" => "123",
          "confirmation_password" => "1234"
        }
        @invalid_user = mock('User', @invalid_user_attrs)
      end
      it "should not create the user" do
        session[:user_id] = nil
        User.should_receive(:new).with(@invalid_user_attrs).and_return(@invalid_user)
        @invalid_user.should_receive(:save).and_return(nil)
        post :create, :user => @invalid_user_attrs
        response.should render_template 'home/index'
      end
    end

    it "if the user is logged in it should render dashboard" do
      session[:user_id] = @user.id
      post :create, :user => @user_attrs
      response.should redirect_to(user_dashboard_path :id => @user.id)
    end
  end

  describe "#dashboard" do

    it "if user is not logged in it should render root" do
      user = mock('User', :id => '1')
      User.stub(:find).with(user.id).and_return(user)
      session[:user_id] = nil
      get :dashboard, :id => user.id
      response.should redirect_to(root_path)
    end

    it "if user is logged in it should render the user dashboard" do
      user = mock('User', :id => '1')
      User.stub(:find).with(user.id).and_return(user)
      session[:user_id] = user.id
      get :dashboard, :id => user.id
      response.should render_template("dashboard")
    end
  end
end
