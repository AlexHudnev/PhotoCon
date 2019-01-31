# frozen_string_literal: true

module Api
  module V1
    class PhotosController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def index
        photos = Photo.approved
        photos = photos.from_user(params[:user_id]) if params[:user_id].present?
        render json: photos, status: 200
      end

      def create
        outcome = CreatePhoto.run(photo_name: params.fetch(:photo)[:photo_name],
                                  photography: params.fetch(:photo)[:photography],
                                  user: current_user)
        if outcome.valid?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end

      def show
        photo = Photo.approved.find(params[:id])
        render json: photo, status: 200
      end
    end
  end
end
