# frozen_string_literal: true

# user controller
class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @photos = Photo.by_approve
  end

  def destroy
    @user = User.find(params[:id])
    return unless @user.id == current_user.id

    @user.destroy
    flash[:success] = 'Account removed '
    redirect_to root_path
  end

  def token
    @user = User.find(params[:id])
    return unless @user.id == current_user.id

    @user.set_access_token
    @user.save
    flash[:success] = 'New token set'
    redirect_to @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
