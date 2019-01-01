class PhotosController < ApplicationController

  def index
    @photo= Photo.where(user_id: current_user.id)
  end

def new
  @photo= Photo.new
end


 def create
   @photo = current_user.photos.build(photo_params)
   if @photo.save
     flash[:success] = "all done"
     redirect_to @photo
   else
     render 'new'
   end
 end

 def show
  @photo = Photo.find(params[:id])
 end

  private

    def photo_params
      params.require(:photo).permit(:photo_name, :photography)
    end

end
