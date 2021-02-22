class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end

def parent_post_or_comment
  return @commentable if @commentable.instance_of?(Post)

  @commentable = @commentable.commentable until @commentable.instance_of?(Post)
  @commentable.id
end
