require 'spec_helper'

describe ContactsListsController do
  describe "GET /contacts_lists" do

    context "User logged in"do
      before do
        session[:user_id] = 1
      end
      it "render the contact lists page with a list of contact lists" do
        get 'index'
         response.should render_template 'index'
      end
    end

    context "User not logged in" do
      before do
        session[:user_id] = nil
      end
      it "redirect to the index page" do
        get 'index'
        response.should redirect_to(root_path)
      end
    end

  end
end
