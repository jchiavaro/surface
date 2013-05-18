require 'spec_helper'

describe ContactsList do

  it "has a valid factory" do
    FactoryGirl.create(:contacts_list).should be_valid
  end
  it "is invalid without a name" do
     FactoryGirl.build(:contacts_list, name: nil).should_not be_valid
  end
  
end
