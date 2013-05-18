class ContactsListsController < ApplicationController
  def sub_layout
    "board"
  end

  # GET /contacts_lists
  def index
    @contacts_lists = ContactsList.all
  end

end
