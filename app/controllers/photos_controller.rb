# frozen_string_literal: true

# Controller for photo
class PhotosController < ApplicationController
  def index
    @photos = Photo.page(params[:page]).by_approve.reorder(params[:sorting])
    @photos = Photo.page(params[:page]).by_approve.by_rating unless params[:sorting].present?
    @sorting = params[:sorting]
  end

  def rating
    @photo = Photo.by_approve
    @steps_lb = Leaderboard.new('Steps', Leaderboard::DEFAULT_OPTIONS, set_redis)
    @photo.each do |photography|
      @steps_lb.rank_member(photography.id, photography.rating)
    end
    lead = @steps_lb.all_leaders
    @steps_results = Kaminari.paginate_array(lead).page(params[:page]).per(6)
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
      flash[:success] = I18n.t(:send_to_moder)
      redirect_to root_path
    else
      @photo = outcome
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def share
    @photo = Photo.find(params[:id])
    sharing = PhotosHelper::Sharing.new
    redirect_to sharing.share(@photo, params[:url])
  end

  def download_zip
    date = Time.now.strftime('%d_%m_%Y_%H_%M')
    zip_file = ZipHelper::ZipPhotos.new
    file = zip_file.make_zip
    send_file file, type: 'application/zip', x_sendfile: true,
                    disposition: 'attachment', filename: "#{date}.zip"
  end

  def destroy
    @photo = Photo.find(params[:id])
    return unless @photo.user_id == current_user.id

    @photo.delete!
    RemovePhotoWorker.perform_in(5.minutes, params[:id])
    flash[:success] = 'Photo removed '
    redirect_to root_path
  end

  def search
    ids = Photo.where('lower(name) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
    ids += Photo.where('lower(description) LIKE ?', "%#{params[:q].mb_chars.downcase}%")
    @photos = Photo.where(id: ids, aasm_state: :approved).page(params[:page])
    flash.now[:warning] = "we can't find it '#{params[:q]}'" unless @photos.any?
  end

  def set_redis
    uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379/')
    redis = Redis.new(url: uri)
    { redis_connection: redis }
  end

  private

  def photo_params
    { name: params.fetch(:photo)[:name],
      description: params.fetch(:photo)[:description],
      photography: params.fetch(:photo)[:photography],
      remote_photography_url: params.fetch(:photo)[:remote_photography_url],
      user: current_user }
  end

  def api_params
    { count: 15, ovner_id: current_user.uid,
      access_token: current_user.access_token,
      v: '5.9', page: 1 }
  end
end
