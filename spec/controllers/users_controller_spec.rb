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
      User.should_receive(:new).with(@user_attrs).and_return(@user)
      @user.should_receive(:save).and_return(@user)
      post :create, :user => @user_attrs
    end

    it "should redirect to the account confirmation" do
      response.should redirect_to confirmation_user_path @user
    end

    it "should make the user available for the next view" do
      assigns(:user).should eq(@user)
    end

    describe "invalid user" do
      before do
        @invalid_user_attrs = {
          "first_name" => "",
          "password" => "123",
          "confirmation_password" => "1234"
        }
        @invalid_user = mock('User', @invalid_user_attrs)
        session[:user_id] = nil
        User.should_receive(:new).with(@invalid_user_attrs).and_return(@invalid_user)
        @invalid_user.should_receive(:save).and_return(nil)
        post :create, user: @invalid_user_attrs

      end
      it "should not create the user" do
        response.should render_template 'index'
      end

      it "should show an error message" do
        flash[:error].should_not be_blank
      end
    end
  end

  describe "#dashboard" do
    before do
      @user = mock('User', :id => '1')
      User.stub(:find).with(@user.id).and_return(@user)
    end
    context "the user is logged in" do
      it "should redirect the user to the dashboard" do
        session[:user_id] = @user.id
        get :dashboard, :id => @user.id
        response.should render_template 'users/dashboard'
      end
    end
    context "the user is not logged in" do
      it "should redirect the user to the home page" do
        session[:user_id] = nil
        get :dashboard, :id => @user.id
        response.should redirect_to(root_path)
      end
    end
  end

  describe "#confirm_account" do
    before do
      @user_attrs = {
        "id" =>  "1",
        "first_name"=> "juan",
        "last_name"=> "smith",
        "email" =>"js@domain.com",
        "password" =>"some_pass",
        "confirmation_password"=> "some_pass",
        "birthday" =>"1987-12-21",
        "gender" =>"Male",
        "auth_code" => "super_secret"
      }
      @user = mock('User', @user_attrs)
      User.stub_chain(:where, :first).and_return(@user)
    end

    context "with a valid auth code" do
      before do
        @user.should_receive(:expired?).and_return false
        @user.should_receive(:update_column).with(:active, true).and_return true
        get :confirm_account, id: @user.id, auth_code: @user.auth_code
      end
      it "should confirm the user account" do
        response.should redirect_to(dashboard_user_path @user)
      end
      it "should save the user into the session" do
        session[:user_id].should == @user.id
      end
    end
    context "with an invalid auth code" do
      it "should redirect the user to the home page" do
        @user.should_receive(:expired?).and_return true
        get :confirm_account, id: @user.id, auth_code: @user.auth_code
        response.should redirect_to(root_path)
      end
    end
  end
end
