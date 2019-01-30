class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :url, :image_url

  def include_url?
    @options[:user_id].present?
  end

  def include_image_url?
    @options[:user_id].present?
  end
end
