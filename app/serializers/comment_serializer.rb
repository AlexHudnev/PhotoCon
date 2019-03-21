# frozen_string_literal: true

# CommentSerializer
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :parent_comment_id

end
