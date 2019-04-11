# frozen_string_literal: true

class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photography,
             :rating, :user_id, :is_liked

  belongs_to :user
  def photo_url
    object.photo.url
  end

  def is_liked
    @instance_options[:liked]
  end
end
