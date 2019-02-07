# frozen_string_literal: true

# comments controller
class CommentsController < ApplicationController
  def new
    @comment = CreateComment.new
  end

  def create
    @photo = Photo.find(params[:photo_id])
    outcome = Comments::Create.run(comment_params)
    if outcome.valid?
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @photo
        end
        format.js
      end
    end
  end

  private

  def comment_params
    { photo: @photo, user: current_user,
      body: params[:comment]['body'],
      parent_comment_id: params[:parent_comment_id] }
  end
end
