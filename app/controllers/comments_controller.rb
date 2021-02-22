class CommentsController < ApplicationController
  before_action :find_commentable, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    return unless @comment.save

    redirect_to post_path(parent_post_or_comment)
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
