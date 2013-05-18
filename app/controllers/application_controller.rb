class ApplicationController < ActionController::Base
  protect_from_forgery

  def sub_layout
    nil
  end
end
