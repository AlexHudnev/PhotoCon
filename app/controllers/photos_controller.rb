# frozen_string_literal: true

# Controller for photo
class PhotosController < ApplicationController
  def index
    @photos = Photo.page(params[:page]).by_approve unless params[:sorting]
    @photos = Photo.page(params[:page]).reorder(params[:sorting])
  end

  def rating
    @photo = Photo.by_approve
    @steps_lb = Leaderboard.new('Steps', Leaderboard::DEFAULT_OPTIONS)
    @photo.each do |photography|
      @steps_lb.rank_member(photography.id, photography.rating)
    end
    @steps_results = Kaminari.paginate_array(@steps_lb.all_leaders).page(params[:page]).per(6)
    @steps_lb.delete_leaderboard
  end

  def gallery
    @photos = Photo.page(params[:page]).by_approve.by_rating
  end

  def new
    return root_path if current_user.moderator

    @photo = Photos::Create.new
    vk = PhotosHelper::Vkontakte.new(api_params)
    @collection = vk.getall['response']['items']
  end

  def create
    return root_path if current_user.moderator

    outcome = Photos::Create.run(photo_params)
    if outcome.valid?
      @photo = outcome.result
      flash[:success] = 'Photo send to moderation '
      redirect_to root_path
    else
      @photo = outcome
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    return unless @photo.user_id == current_user.id

    @photo.destroy
    flash[:success] = 'Photo removed '
    redirect_to root_path
  end

  def search
    ids = Photo.where('lower(name) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
    @photos = Photo.where(id: ids, aasm_state: :approved).page(params[:page])
    flash.now[:warning] = "we can't find it '#{params[:q]}'" unless @photos.any?
  end

  private

  def photo_params
    { name: params.fetch(:photo)[:name],
      photography: params.fetch(:photo)[:photography],
      remote_photography_url: params.fetch(:photo)[:remote_photography_url],
      user: current_user }
  end

  def api_params
    { count: 100, ovner_id: current_user.uid,
      access_token: current_user.access_token,
      v: '5.9', page: 1 }
  end
end
