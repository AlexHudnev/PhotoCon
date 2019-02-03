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
    @photos = Photo.page(params[@user.uid]).by_approve
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
