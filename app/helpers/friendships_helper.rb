module FriendshipsHelper
  def friendship_status(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    return "#{friend.name} is not your friend (yet)." if friendship.nil?

    case friendship.status
    when 'Pending'
      'Request sent'
    when 'Accepted'
      'Request Accepted'
    end
  end
end
