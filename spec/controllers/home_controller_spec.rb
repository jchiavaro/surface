require "spec_helper"

describe HomeController do
  describe "#index" do
    before do
      @user = mock('User', :id => '1')
      session[:user_id] = @user.id
    end
    context "when the user is logged in" do
      it "should redirect to the user dashboard" do
        get 'index'
        response.should redirect_to dashboard_user_path(@user.id)
      end
    end

    context "when the user is not logged in" do
      it "should redirect to the home page" do
        session[:user_id] = nil
        get 'index'
        response.should render_template "home"
      end
    end
  end
end
