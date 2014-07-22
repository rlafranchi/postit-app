class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

  def require_user
    if !logged_in?
      flash[:notice] = "Please log in"
      redirect_to root_path
    end
  end

  def require_creator
    if logged_in? && @post.creator != current_user
      flash[:notice] = "You didn't create that post"
      redirect_to root_path
    end
  end
end
