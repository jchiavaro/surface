require "spec_helper"

describe UserMailer do
  describe "#welcome_email" do
    before do
      @user = mock("User", { id: 1, first_name: "Carl", email: "user@domain.com", auth_code: "secure_token" })
    end
    it "should send a welcome email" do
      email = UserMailer.welcome_email(@user).deliver
      assert !ActionMailer::Base.deliveries.empty?
      assert_equal ["surfacenotifications@surface.com"], email.from
      assert_equal [@user.email], email.to
      assert_match /Welcome to Surface!, #{@user.first_name}/, email.encoded
      assert_equal "Welcome to Surface!", email.subject
    end

    it "Should assign the confirmation url" do
      email = UserMailer.welcome_email(@user).deliver
      email.body.encoded.should match("<a href='http://localhost:3000/users/#{@user.id}/account/#{@user.auth_code}'>Confirm Account</a>")
    end
  end
end
