# frozen_string_literal: true

class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :created_at
end
