module ApplicationHelper
  def friend_reqs
    @users = User.all_except(current_user).reject { |u| Friendship.exists?(current_user, u) }.sample(3)
  end
end
