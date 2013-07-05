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
      format.js   { render :success}
    end
  end

  # GET /contacts/new
  def new
    @cl = ContactsList.find(params[:cl_id])
    @c = Contact.new
    respond_to do |format|
      format.js   { render :modal}
    end
  end

  # POST /contacts
  def create
    @cl = ContactsList.find(session[:cl_id]);
    @contact = Contact.new(params[:contact])
    if @contact.save
      @cl.contact.push(@contact)
        respond_to do |format|
        format.js   { render :success}
        end
    else
      
      respond_to do |format|
        format.js   { render :errors, :locals => {
            :first_name_error => "#{@contact.errors[:first_name].first}" ,
            :email_error_empty => "#{@contact.errors[:email].first}",
            :email_error_invalid => "#{@contact.errors[:email].second }"}
        }
      end
    end
    
    
  end

 
end
