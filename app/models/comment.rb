# frozen_string_literal: true

# comment model
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo, counter_cache: :comment_count
  has_many   :sub_comments, class_name: 'Comment',
                            foreign_key: 'parent_comment_id',
                            dependent: :destroy
  belongs_to :parent_comment, class_name: 'Comment',
                              foreign_key: 'parent_comment_id',
                              optional: true
  validates :body, presence: true, length: { minimum: 1 }
end
