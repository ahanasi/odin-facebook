class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  scope :all_except, ->(user) { where.not(id: user) }

  has_many :posts
  has_many :photos, through: :posts, source: :image_attachment
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'
  has_many :friendships
  has_many :friends, -> { Friendship.accepted }, through: :friendships
  has_many :pending_friends, -> { Friendship.pending }, through: :friendships, source: :friend
  has_many :requested_friends, -> { Friendship.requested }, through: :friendships, source: :friend

  has_one_attached :avatar

  def relevant_posts
    relevant_posts = []
    friends.each do |f|
      f.posts.each do |p|
        relevant_posts << p
      end
    end
    posts.each do |p|
      relevant_posts << p
    end
    relevant_posts
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user ||= User.create(name: data['name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20],
                         avatar_url: data['image'])
    user
  end
end
