# frozen_string_literal: true

# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    Likes::Create.run(photo: @photo, user: current_user)
    respond @photo
    Comments::Acieve.run(photo: @photo) if @photo.rating == 3
  end

  def destroy
    like = Like.find(params[:id])
    @photo = Photo.find(like.photo_id)
    return unless like.user_id == current_user.id

    like.destroy
    respond @photo
  end

  def respond(photo)
    respond_to do |format|
      format.html do
        redirect_to photo
      end
      format.js
    end
  end
end
