require "spec_helper"

describe "the signin process" do
  before :each do
    @user = FactoryGirl.create(:user)
    @inactive_user = FactoryGirl.create(:inactive_user)
    visit '/'
  end

  context "with a valid user" do
    it "signs me in" do
      within("#signin_form") do
        fill_in 'user_email', with: @user.email
        fill_in 'user_password', with: @user.password
      end
      click_button 'Sign in'
      page.should have_content 'Welcome again'
    end
  end

  context "invalid user" do
    describe "worng credentials" do
      it "should not login the user" do
        within("#signin_form") do
          fill_in 'user_email', with: "admin@domain.com"
          fill_in 'user_password', with: "secret"
        end
        click_button 'Sign in'
        page.should have_content 'Invalid Email/Password combination'
      end
    end

    describe "with an inactive user" do
      it "should not login the user" do
        within("#signin_form") do
          fill_in 'user_email', with: @inactive_user.email
          fill_in 'user_password', with: @inactive_user.password
        end
        click_button 'Sign in'
        page.should have_content 'Invalid Email/Password combination'
      end
    end
  end
end
