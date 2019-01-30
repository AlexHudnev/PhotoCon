class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :parent_comment_id

 has_many :sub_comments

 def sub_comments
   sub_comments = @options[:user_id].blank? ? object.sub_comments : []
 end
end
