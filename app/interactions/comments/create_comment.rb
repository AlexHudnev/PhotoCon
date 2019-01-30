# frozen_string_literal: true

# create comment
class CreateComment < ActiveInteraction::Base
  object :user
  object :photo
  string :body
  integer :parent_comment_id, default: nil

  def to_model
    Comment.new
  end

  def execute
    comment = photo.comments.build(body: body, user_id: user.id)
    comment.parent_comment_id = parent_comment_id
    comment.save
  end
end
