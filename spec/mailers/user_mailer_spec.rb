require "spec_helper"

describe UserMailer do
  context "#welcome_email" do
    let(:user) { stub(id: 1, first_name: "Carl", email: "user@domain.com", auth_code: "secure_token") }
    subject{ UserMailer.welcome_email(user) }

    its(:from) { should include("surfacenotifications@surface.com") }
    its(:to) { should include(user.email) }
    its(:subject) { should == "Welcome to Surface!" }
    its(:encoded) { should match("Welcome to Surface!, #{user.first_name}")}
    its("body.encoded") { should match("<a href='http://localhost:3000/users/#{user.id}/account/#{user.auth_code}'>Confirm Account</a>") }
  end
end
