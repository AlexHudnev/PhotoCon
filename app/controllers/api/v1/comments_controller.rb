# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      layout false
      before_action :verify_authenticity_token, only: %i[create index]

      def create
        raise ::Errors::Ban if @api_user.ban

        validate Comments::Create.run(comment_params)
      end

      def index
        photo = Photo.find(params[:photo_id])
        raise ::Errors::InvalidRequestData unless photo

        comments = photo.comments.page(params[:page]).per(params[:per_page])
        render json: comments, status: :ok
      end

      private

      def comment_params
        photo = Photo.find(params[:photo_id])
        { photo: photo, user: @api_user,
          body: params[:comment],
          parent_comment_id: params[:parent_comment_id] }
      end
    end
  end
end
