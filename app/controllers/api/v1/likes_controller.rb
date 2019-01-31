# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def create
        @photo = Photo.find(params[:photo_id])
        outcome = CreateLike.run(photo: @photo, user: current_user)
        if outcome.valid?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end
    end
  end
end
