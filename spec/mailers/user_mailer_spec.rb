require "spec_helper"

describe UserMailer do
  describe "#welcome_email" do
    before do
      @user = mock("User", { first_name: "Carl", email: "user@domain.com" })
    end
    it "should send a welcome email" do
      email = UserMailer.welcome_email(@user).deliver
      assert !ActionMailer::Base.deliveries.empty?
      assert_equal ["surfacenotifications@surface.com"], email.from
      assert_equal [@user.email], email.to
      assert_match /Welcome to Surface!, #{@user.first_name}/, email.encoded
      assert_equal "Welcome to Surface!", email.subject
    end
  end
end
