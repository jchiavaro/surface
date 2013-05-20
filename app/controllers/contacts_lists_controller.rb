class ContactsListsController < ApplicationController
  include SessionsHelper

  def sub_layout
    "board"
  end

  # GET /contacts_lists
  def index
    @contacts_lists = ContactsList.where(:user_id => current_user.id)
    render 'index' if signed_in?
  end

end
