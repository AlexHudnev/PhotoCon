# comments controller
class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:success] = 'Comment posted.'
          redirect_to @photo
        end
        format.js # JavaScript response
      end
    end
    #redirect_to request.referer
  end

  def create_sub_comment
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.parent_comment_id = params[:parent_comment_id]
    @comment.user_id = current_user.id
    @comment.save
    while @comment.parent_comment
      parent_comment = @comment.parent_comment
      parent_comment.updated_at = @comment.updated_at
      parent_comment.save
      @comment = parent_comment
    end
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
