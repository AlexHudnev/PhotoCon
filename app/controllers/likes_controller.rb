# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build
    @like.user_id = current_user.id
    if @like.valid?
      @like.save
      respond_to do |format|
        format.html do
          redirect_to @photo
        end
        format.js # JavaScript response
      end
    else
      flash[:warning] = 'You cant like twice.'
      redirect_to root_path
    end
  end
end
