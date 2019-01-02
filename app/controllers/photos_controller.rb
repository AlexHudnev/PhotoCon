class PhotosController < ApplicationController

  def index
    #@photo= Photo.where(user_id: current_user.id)
#@photos= Photo.all
@photos = params[:sorting] ?Photo.page(params[:page]).reorder(params[:sorting]) : Photo.page(params[:page])
  end

def new
  @photo= Photo.new
end


 def create
   @photo = current_user.photos.build(photo_params)
   @photo.rating = 0
   @photo.save
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
 def search
     ids =[]
     Photo.all.each {|n| ids << n.id if n.photo_name.mb_chars.downcase.include?(params[:q].mb_chars.downcase) }
     @photos = Photo.where(id: ids)

     flash.now[:warning] = "we can't find it '#{params[:q]}' ." unless @photos.any?
   end
  private

    def photo_params
      params.require(:photo).permit(:photo_name, :photography)
    end

end
