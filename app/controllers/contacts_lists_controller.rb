class ContactsListsController < ApplicationController
  include SessionsHelper

  def sub_layout
    "board"
  end

  # GET /contacts_lists
  def index
    if signed_in?
      @contacts_lists = ContactsList.where(:user_id => current_user.id)
      render 'index'
    else
      redirect_to root_path
    end
  end

end
