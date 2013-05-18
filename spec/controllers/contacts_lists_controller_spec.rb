require 'spec_helper'


describe ContactsListsController do
 describe "GET /contacts_lists" do
    it "should render the contact lists page with a list of contact lists" do
      get 'index'
      response.status.should be 200
    end
  end

end
