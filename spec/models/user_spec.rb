require "spec_helper"

describe User do
  before do
    @user = User.new(first_name: "Example User", last_name: "Last Name",  email: "user@example.com", password: "foobar", password_confirmation: "foobar", birthday: "1982-12-18", gender: "Female")
  end

  subject { @user }

  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:authenticate) }
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

  describe "#create" do
    let(:user_attrs){{
      first_name: "juan",
      last_name: "smith",
      email: "js@domain.com",
      password: "some_pass",
      password_confirmation: "some_pass",
      birthday: "1987-12-21",
      gender: "Male"}
    }

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

      describe "email is already taken" do
        it "should not be valid" do
          user = User.create!(user_attrs)
          another_user = user.dup
          another_user.email = user.email.upcase
          another_user.save
          another_user.should_not be_valid
        end
      end
    end
  end
end
