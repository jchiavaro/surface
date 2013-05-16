require "spec_helper"

describe User do
  before do
    @user = User.new({first_name: "Example User", last_name: "Last Name",  email: "user@example.com", password: "foobar", password_confirmation: "foobar", birthday: "1982-12-18", gender: "Female", expires_at: Time.now + 4.days})
  end

  subject { @user }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:auth_code) }
  it { should respond_to(:expires_at) }
  it { should respond_to(:expired?) }
  it { should respond_to(:active) }
  it { should be_valid }

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "#expired" do
    describe "when auth code has expired" do
      it "should return true" do
        @user.should be_expired
      end
    end
    describe "with a valid auth code" do
      it "should return false" do
        @user.expires_at = Time.now - 2.days
        @user.should_not be_expired
      end
    end
  end

  describe "actives" do
    let(:user_attrs){{
      first_name: "juan",
      last_name: "smith",
      email: "js@domain.com",
      password: "some_pass",
      password_confirmation: "some_pass",
      birthday: "1987-12-21",
      gender: "Male",
      auth_token: nil}}

      it "should include users with active flag" do
        user_attrs[:active] = true
        active = User.create! user_attrs
        User.actives.should include(active)
      end
      it "should not include active users with no active flag" do
        active = User.create! user_attrs
        User.actives.should_not include(active)
      end
  end

  describe "#create" do
    let(:user_attrs){{
      first_name: "juan",
      last_name: "smith",
      email: "js@domain.com",
      password: "some_pass",
      password_confirmation: "some_pass",
      birthday: "1987-12-21",
      gender: "Male",
      auth_token: nil}}

    it "should create a new user" do
      user = User.create!(user_attrs)
      user.id.should_not be_nil
      user.first_name.should_not be_nil
    end

    context "invalid user fields" do
      describe "first_name is not present" do
        before { user_attrs[:first_name] = "" }

        it "should not save the user" do
          expect{User.create!(user_attrs)}.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      describe "last_name is too long" do
        before { user_attrs[:last_name] = "a" * 50 }

        it "should not save the user" do
          user = User.new(user_attrs)
          user.should_not be_valid
        end
      end

      describe "email format is invalid" do
        it "should not be valid" do
          user = User.new(user_attrs)

          addresses = %w{user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com}
          addresses.each do |invalid_address|
            user.email = invalid_address
            user.should_not be_valid
          end
        end
      end

      describe "#authenticate" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) }
        describe "with valid password" do
          it { should == found_user.authenticate(@user.password) }
        end

        describe "with invalid password" do
          let(:user_for_invalid_password) { found_user.authenticate("invalid") }

          it { should_not == user_for_invalid_password }
          specify { user_for_invalid_password.should be_false }
        end
      end

      describe "email is already taken" do
        it "should not be valid" do
          user = User.create!(user_attrs)
          another_user = user.dup
          another_user.email = user.email.upcase
          another_user.save
          another_user.should_not be_valid
        end
      end
      context "user callbacks" do
        describe "after_save" do
          it "should send a confirmation email" do
            user = User.new(user_attrs)
            user.should_receive(:send_welcome_email)
            user.save
          end
        end

        describe "before_save" do
          before { @user = User.new(user_attrs) }
          it "should downcase the email" do
            @user.email = "EMAIL@domAIN.COM"
            @user.save
            @user.email.should == "email@domain.com"
          end
          it "should generate an authorization token" do
            @user.should_receive(:generate_auth_token)
            @user.save
          end
          it "should have an auth code" do
            @user.save
            @user.auth_code.should_not be_nil
          end
          it "should set the expiration date" do
            @user.save
            @user.expires_at.should_not be_nil
          end
        end
      end
    end
  end
end
