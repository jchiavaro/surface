class HomeController < ApplicationController
  before_filter :save_login_state, :only => [:index]
  def index
    @user ||= User.new
  end
end
