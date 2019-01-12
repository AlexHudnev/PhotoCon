# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = @photo.likes.build
    respond_to do |format|
      @like.user_id = current_user.id
      if @like.valid?
        @like.save
        #flash[:success] = '!'
        format.html { redirect_to root_path }
        format.js
      else
        flash[:warning] = '!'
        redirect_to root_path
      end
    end
  end
end
