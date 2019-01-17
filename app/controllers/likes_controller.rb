# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build
    @like.user_id = current_user.id
    if @like.valid?
      @like.save
    else
      flash[:warning] = '!'
      redirect_to root_path
    end
  end
end
