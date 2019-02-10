# frozen_string_literal: true

module Api
  module V1
    # api photos controller
    class PhotosController < ApiController
      layout false
      before_action :autorization, only: :create

      def index
        photos = Photo.approved
        photos = photos.from_user(params[:user_id]) if params[:user_id].present?
        render json: photos, status: :ok
      end

      def create
        return if current_user.moderator

        validate Photos::Create.run(photo_params)
      end

      def show
        photo = Photo.approved.find(params[:id])
        render json: photo, status: :ok
      end

      private

      def photo_params
        { name: params.fetch(:photo)[:name],
          photography: params.fetch(:photo)[:photography],
          remote_photography_url: params.fetch(:photo)[:remote_photography_url],
          user: current_user }
      end
    end
  end
end
