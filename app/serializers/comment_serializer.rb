# frozen_string_literal: true

# CommentSerializer
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :body, :parent_comment_id, :created_at
end
