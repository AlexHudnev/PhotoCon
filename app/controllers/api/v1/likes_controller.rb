# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApiController
      layout false
      before_action :autorization, only: :create

      def create
        @photo = Photo.find(params[:photo_id])
        validate Likes::Create.run(photo: @photo, user: current_user)
      end
    end
  end
end
