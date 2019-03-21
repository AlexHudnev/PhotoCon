# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApiController
      layout false
      before_action :verify_authenticity_token, only: :create

      def create
        raise ::Errors::Ban if @api_user.ban

        @photo = Photo.find(params[:photo_id])
        validate Likes::Create.run(photo: @photo, user: @api_user)
      end
    end
  end
end
