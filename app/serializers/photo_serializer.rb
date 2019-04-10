# frozen_string_literal: true

class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photography,
             :rating, :user_id

  belongs_to :user
  def photo_url
    object.photo.url
  end
end
