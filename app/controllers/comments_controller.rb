require "pry"
class CommentsController < ApplicationController
  before_action :find_commentable, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @commentable.comments.build(comment_params)
    if @commentable.save
        binding.pry
      if @commentable.class.name == 'Post'
        redirect_to @commentable
      else
        redirect_to Post.find(@commentable.commentable_id)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
    end
  end
end
