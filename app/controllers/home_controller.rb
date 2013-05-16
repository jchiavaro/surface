class HomeController < ApplicationController
  include SessionsHelper

  def index
    redirect_to dashboard_user_path(current_user) if signed_in?
  end
end
