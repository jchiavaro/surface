class ContactsController < ApplicationController

  
   # GET /contacts/load_contacts
  def load_contacts
    if params[:id]== 'select'
      @cl = ContactsList.new
    else
      @cl =  ContactsList.find(params[:id])
    end
    
    session[:cl_id] = @cl.id
    respond_to do |format|
      format.js   { render :load_contacts}
    end
  end

  # GET /contacts/new
  def new
    @cl = ContactsList.find(params[:cl_id])
    @c = Contact.new
    respond_to do |format|
      format.js   { render :contact_modal}
    end
  end

  # POST /contacts
  def create
    @contact = Contact.new(params[:contact])
    @cl = ContactsList.find(session[:cl_id]);
    @cl.contact.push(@contact)
    respond_to do |format|
      format.js   { render :load_contacts}
    end
  end

 
end
