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
        format.js   { render :errors, :locals => errors_hash(@contact)}
      end
    end
  end


  # GET /contacts/1/edit
  def edit
    @c = Contact.find(params[:id])
    respond_to do |format|
      format.js   { render :modal}
    end
  end

  # PUT /contacts/1
  def update
    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        @cl = ContactsList.find(session[:cl_id]);
        format.js   { render :success}
      else
        format.js   { render :errors, :locals => errors_hash(@contact) }
      end
    end
  end

   # DELETE /contacts/1
  def destroy
    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.destroy
        @cl = ContactsList.find(session[:cl_id]);
        format.js   { render :success}
      else
        format.js   { render :errors}
      end
    end
  end

  # render delete modal
  def delete
    @c = Contact.find(params[:id])
    respond_to do |format|
      format.js   { render :delete_modal}
    end
  end

  def errors_hash obj
    {
      :first_name_error => "#{obj.errors[:first_name].first}" ,
      :email_error_empty => "#{obj.errors[:email].first}",
      :email_error_invalid => "#{obj.errors[:email].second }"
    }
  end

 
end
