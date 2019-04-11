# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      layout false
      before_action :verify_authenticity_token, only: %i[destroy current]

      def index
        users = User.all.page(params[:page]).per(params[:per_page])
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        raise ::Errors::InvalidRequestData unless user

        render json: user, user_id: user.id, status: :ok
      end

      def destroy
        user = User.find(params[:id])
        raise ::Errors::Unright unless @api_user.id == user.id

        user.destroy
        render json: { message: 'removed' }, status: :ok
      end

      def current
        raise ::Errors::InvalidRequestData unless @api_user

        render json: @api_user, user_id: @api_user.id, status: :ok
      end

      def photos
        user = User.find(params[:id])
        raise ::Errors::InvalidRequestData unless user

        photos = Photo.where(user_id: user).page(params[:page]).per(params[:per_page])
        render json: photos, status: :ok
      end
    end
  end
end
