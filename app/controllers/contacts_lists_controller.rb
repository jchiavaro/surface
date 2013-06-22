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

  # GET /contacts_lists/new
  def new
    @cl = ContactsList.new
    respond_to do |format|
      format.js   { render :modal}
    end
  end
  
  # GET /contacts_lists/1/edit
  def edit
    @cl = ContactsList.find(params[:id])
    respond_to do |format|
      format.js   { render :modal}
    end
  end

  def delete
    @cl = ContactsList.find(params[:id])
    respond_to do |format|
      format.js   { render :delete_modal}
    end
  end



  # PUT /contacts_lists/1
  def update
    puts "Llamo a update"
    @contacts_list = ContactsList.find(params[:id])
    respond_to do |format|
      if @contacts_list.update_attributes(params[:contacts_list])
        format.js   { render :success}
      else
        format.js   { render :errors}
      end
    end
  end

  # POST /contacts_lists
  def create
    puts "Llamo a create"
    @contacts_list = ContactsList.new(params[:contacts_list])
    @contacts_list.user = current_user;
    respond_to do |format|
      if @contacts_list.save
        format.js   { render :success}
      else
        format.js   { render :errors}
      end
    end
  end

  # DELETE /contacts_lists/1
  def destroy
    @contacts_list = ContactsList.find(params[:id])
    respond_to do |format|
      if @contacts_list.destroy
        format.js   { render :success}
      else
        format.js   { render :errors}
      end
    end
  end

end
