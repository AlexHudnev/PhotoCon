# frozen_string_literal: true

# Controller for photo
class PhotosController < ApplicationController
  def index
    @photos = params[:sorting] ? Photo.page(params[:page]).reorder(params[:sorting]) : Photo.page(params[:page]).by_approve
  end

  def rating
    @pho = Photo.page(params[:page]).by_approve
    @steps_lb = Leaderboard.new('Steps', Leaderboard::DEFAULT_OPTIONS)
    @pho.each do |photography|
      @steps_lb.rank_member(photography.id, photography.rating)
    end
    @steps_results = Kaminari.paginate_array(@steps_lb.all_leaders).page(params[:page]).per(10)
  end

  def gallery
    @photos = Photo.page(params[:page]).by_approve.by_rating

  end

  def new
    @photo = CreatePhoto.new
  end

  def create
    outcome = CreatePhoto.run(name: params.fetch(:photo)[:name],
                              photography: params.fetch(:photo)[:photography],
                              user: current_user)
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

  def search
    ids = []
    Photo.all.each {|n| ids << n.id if n.name.mb_chars.downcase.include?(params[:q].mb_chars.downcase) }
    @photos = Photo.where(id: ids, aasm_state: :approved).page(params[:page])
    flash.now[:warning] = "we can't find it '#{params[:q]}'" unless @photos.any?
  end
end
