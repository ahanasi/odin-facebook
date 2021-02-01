module LikesHelper
  def already_liked?(post)
    Like.where(user_id: current_user.id, post_id: post.id).exists?
  end
end
