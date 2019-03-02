# frozen_string_literal: true

class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photography, :rating, :user_id

  def photo_url
    object.photo.url
  end
end
