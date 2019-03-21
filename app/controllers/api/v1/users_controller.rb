# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      layout false
      before_action :verify_authenticity_token, only: :destroy

      def index
        users = User.all.page(params[:page]).per(params[:per_page])
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        raise ::Errors::InvalidRequestData unless user

        render json: user, include: :photos, user_id: user.id, status: :ok
      end

      def destroy
        user = User.find(params[:id])
        raise ::Errors::Unright unless @api_user.id == user.id

        user.destroy
        render json: { message: 'removed' }, status: :ok
      end
    end
  end
end
