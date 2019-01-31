class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo_name, :photography, :rating, :user_id

  def photo_url
    object.photo.url
  end
end
