module ApplicationHelper
  include LikesHelper
  def friend_reqs
    @users = User.with_attached_avatar.all_except(current_user).reject { |u| Friendship.exists?(current_user, u) }.sample(3)
  end

  def user_avatar(user, size = 40)
    if user.avatar.attached?
      user.avatar.variant(resize_to_fit: [size, size])
    elsif user.avatar_url
      user.avatar_url
    else
      gravatar_image_url(user.email, size: size)
    end
  end
end
