# frozen_string_literal: true

# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    Likes::Create.run(photo: @photo, user: current_user)
    Comments::Acieve.run(photo: @photo) if @photo.rating == 3
  end

  def destroy
    like = Like.find(params[:id])
    @photo = Photo.find(like.photo_id)
    return unless like.user_id == current_user.id

    like.destroy
  end
end
