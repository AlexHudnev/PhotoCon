class CommentsController < ApplicationController

  def create
      @photo= Photo.find(params[:photo_id])
      @comment = @photo.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      redirect_to root_path
    end

    private
      def comment_params
        params.require(:comment).permit(:body, :user_id)
      end
end
