class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user.role == 'admin'
  end

  private

  def not_permitted
    flash[:notice] = "Not Allowed!"
    redirect_to root_path
  end

  def require_user
    not_permitted unless logged_in?
  end

  def require_creator
    not_permitted unless logged_in? && @post.creator == current_user
  end

  def require_admin
    not_permitted unless logged_in? && admin?
  end
end
