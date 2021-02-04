module ApplicationHelper
  include LikesHelper
  def friend_reqs
    @users = User.all_except(current_user).reject { |u| Friendship.exists?(current_user, u) }.sample(3)
  end

  def user_avatar(user, size = 40)
    if user.avatar.attached?
      user.avatar.variant(resize_to_fit: [size, size])
    else
      gravatar_image_url(user.email, size: size)
    end
  end
end
