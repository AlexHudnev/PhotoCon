# frozen_string_literal: true

module Api
  module V1
    # api photos controller
    class PhotosController < ApiController
      layout false
      before_action :verify_authenticity_token, only: [:create, :destroy]

      def index
        photos = Photo.approved.page(params[:page]).per(params[:per_page])
        photos = photos.reorder(params[:sorting]) if params[:sorting].present?
        photos = photos.find_by(id: params[:user_id]) if params[:user_id].present?
        render json: photos, status: :ok
      end

      def create
        raise ::Errors::Unright if @api_user.moderator
        raise ::Errors::Ban if @api_user.ban

        validate Photos::Create.run(photo_params)
      end

      def destroy
        photo = Photo.find(params[:id])
        raise ::Errors::Unright unless @api_user.id == photo.user_id

        photo.delete!
        render json: { message: 'removed' }, status: :ok
      end

      def show
        photo = Photo.approved.find(params[:id])
        raise ::Errors::InvalidRequestData unless photo

        render json: photo, status: :ok
      end

      private
      def photo_params
        { name: params[:name],
          photography: params[:photography],
          remote_photography_url: params[:remote_photography_url],
          user: @api_user }
      end
    end
  end
end
