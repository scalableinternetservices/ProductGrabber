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
    @user=current_user

    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    if @user.cart.nil?
      cart = Cart.create
      cart.get_items(nil)
      @user.cart=cart
      session[:cart_id] = cart.id
      cart
    else
      session[:cart_id] = @user.cart.id
      @user.cart.get_items(nil)
      @user.cart
    end
  end


  def log_out
    session.delete(:user_id)
    session.delete(:cart_id)
    @current_user = nil
  end
end

