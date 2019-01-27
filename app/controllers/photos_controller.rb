# Controller for photo
class PhotosController < ApplicationController
  def index
    @photos = params[:sorting] ? Photo.page(params[:page]).reorder(params[:sorting]) : Photo.page(params[:page]).by_approve
  end

  def rating
    @pho = Photo.page(params[:page]).by_approve
    redis_options = {url: ENV['REDIS_URL'] }
    @steps_lb = Leaderboard.new('Steps', Leaderboard::DEFAULT_OPTIONS, redis_options)
    @pho.each do |photography|
      @steps_lb.rank_member(photography.photo_name, photography.rating)
    end
    @steps_results = Kaminari.paginate_array((@steps_lb.all_leaders)).page(params[:page]).per(10)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.rating = 0
    @photo.comment_count = 0
    @photo.save
    if @photo.save
      flash[:success] = 'Photo send to moderation'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @comments = @photo.comments
    @new_comment = @photo.comments.new
  end

  def search
    ids = []
    Photo.all.each {|n| ids << n.id if n.photo_name.mb_chars.downcase.include?(params[:q].mb_chars.downcase) }
    @photos = Photo.where(id: ids, aasm_state: :approved).page(params[:page])
    flash.now[:warning] = "we can't find it '#{params[:q]}' ." unless @photos.any?
  end

  private

  def photo_params
    params.require(:photo).permit(:photo_name, :photography)
  end
end
