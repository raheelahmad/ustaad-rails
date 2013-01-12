class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:remember_token] = @user.remember_token
      redirect_to root_path, notice:"You have been signed up"
    else
      flash[:error] = "Error signing up"
      render "new"
    end
  end

  def edit
    if current_user
      @user = current_user
    else
      redirect_to root_path 
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      cookies[:remember_token] = @user.remember_token
      redirect_to root_path, notice:"Your profile has been updated"
    else
      flash[:error] = "Error updating your profile"
      render "edit"
    end
  end
end
