include SessionsHelper

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def logged_in_user
    unless logged_in?
      #flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

