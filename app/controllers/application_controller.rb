include SessionsHelper

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in_user
    unless logged_in?
      #flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def log_out
    session.delete(:user_id)
    current_cart
    @cart=Cart.find(session[:cart_id])
    @cart.destroy
    session.delete(:cart_id)
    @current_user = nil
  end
end

