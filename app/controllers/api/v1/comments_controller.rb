# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      layout false
      before_action :autorization, only: :create

      def create
        @photo = Photo.find(params[:photo_id])
        outcome = CreateComment.run(photo: @photo, user: current_user,
                                    body: params[:comment]['body'],
                                    parent_comment_id: params[:parent_comment_id])
        if outcome.valid?
          render nothing: true, status: 201
        else
          render json: outcome.errors.symbolic, status: 422
        end
      end
    end
  end
end
