class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }

  has_many :posts
  has_many :friendships
  has_many :friends, -> { Friendship.accepted }, through: :friendships
  has_many :pending_friends, -> { Friendship.pending }, through: :friendships, source: :friend
  has_many :requested_friends, -> { Friendship.requested }, through: :friendships, source: :friend
end
