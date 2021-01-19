require 'pry'
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  scope :accepted, -> { where('status = ?', 'Accepted').order('name ASC') }
  scope :pending, -> { where('status = ?', 'Pending').order('created_at DESC') }
  scope :requested, -> { where('status = ?', 'Requested').order('created_at DESC') }

  validates_presence_of :user_id, :friend_id

  def self.exists?(user, friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend)
    return if (user == friend) || Friendship.exists?(user, friend)

    transaction do
      create(user: user, friend: friend, status: 'Pending')
      create(user: friend, friend: user, status: 'Requested')
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
      destroy(find_by_user_id_and_friend_id(user, friend).id)
      destroy(find_by_user_id_and_friend_id(friend, user).id)
    end
  end

  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'Accepted'
    request.save!
  end
end
