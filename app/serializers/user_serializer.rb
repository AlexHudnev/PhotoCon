class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :url, :image_url
end
