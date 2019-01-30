# frozen_string_literal: true

# create photo
class CreateLike < ActiveInteraction::Base
  object :user
  object :photo

  def execute
    like = photo.likes.build
    like.user_id = user.id
    like.save
  end
end
