class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  validates_presence_of :user_id, :friend_id

  self.exists?(user,friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend)
    unless user == friend or Friendship.exists(user, friend)
      transaction do
        create(user: user, friend: friend, status: "Pending")
        create(user: friend, friend: user, status: "Requested")
      end
    end
  end

  def self.accept(user, friend)
    transaction do 
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
    end
  end

  private

  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = "Accepted"
    request.save!
  end
end
