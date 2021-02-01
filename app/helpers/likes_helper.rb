module LikesHelper
  def already_liked?(likeable)
    if likeable.instance_of?(Post)
      Like.where(user_id: current_user.id, likeable_id: likeable.id, likeable_type: 'Post').exists?
    elsif likeable.instance_of?(Comment)
      Like.where(user_id: current_user.id, likeable_id: likeable.id, likeable_type: 'Comment').exists?
    end
  end
end
