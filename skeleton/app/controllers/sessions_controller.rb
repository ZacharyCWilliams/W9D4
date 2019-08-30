class SessionsController < ApplicationController
  
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user 
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    # flash[:success] = 'Logged out successfully'
    redirect_to cats_url

  end
end

