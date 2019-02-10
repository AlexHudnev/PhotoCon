# frozen_string_literal: true

module Likes
  class Create < ActiveInteraction::Base
    object :user
    object :photo

    def execute
      photo.likes.create(user_id: user.id)
    end
  end
end
