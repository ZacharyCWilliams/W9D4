class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def logged_in?
    !!current_user
  end


  def current_user
    return nil if session[:session_token]
    User.find_by(session_token: session[:session_token])
  end
end
