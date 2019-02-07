# frozen_string_literal: true

module Api
  module V1

    class UsersController < ApplicationController
      layout false

      def index
        users = User.all
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: user, user_id: user.id, status: :ok
      end
    end
  end
end
