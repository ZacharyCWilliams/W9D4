class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(username: params[:user][:username], password: params[:user][:password])

    if @user.save
      render plain: 'registration successful'
    else
      render plain: 'user could not be saved successfully'
    end
  end
end
