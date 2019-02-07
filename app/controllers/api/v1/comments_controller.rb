# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApiController
      layout false
      before_action :autorization, only: :create

      def create
        validate Comments::Create.run(comment_params)
      end

      private

      def comment_params
        photo = Photo.find(params[:photo_id])
        { photo: photo, user: current_user,
          body: params[:comment]['body'],
          parent_comment_id: params[:parent_comment_id] }
      end
    end
  end
end
