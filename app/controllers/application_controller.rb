class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def authorize
    redirect_to signin_url if current_user.nil?
  end

  def tab_name
    params[:controller]    
  end

  private
    def current_user
      @current_user ||= User.find_by_id(cookies[:user_id]) if cookies[:user_id]
    end
end
