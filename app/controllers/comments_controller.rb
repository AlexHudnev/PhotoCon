# comments controller
class CommentsController < ApplicationController
  def new
    @comment = CreateComment.new
  end

  def create
    @photo = Photo.find(params[:photo_id])
    outcome = CreateComment.run(photo: @photo, user: current_user,
                                body: params[:comment]['body'],
                                parent_comment_id: params[:parent_comment_id])
    if outcome.valid?
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @photo
        end
        format.js # JavaScript response
      end
    end
  end
end
