# frozen_string_literal: true

module Comments
  class Create < ActiveInteraction::Base
    object :user
    object :photo
    string :body
    integer :parent_comment_id, default: nil

    def to_model
      Comment.new
    end

    def execute
      photo.comments.create(body: body, user_id: user.id,
                            parent_comment_id: parent_comment_id)
    end
  end
end
