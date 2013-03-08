class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    redirect_to login_url, alert: 'Please log in first' if current_user.nil?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
