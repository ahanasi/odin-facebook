class LikesController < ApplicationController
  # before_action :set_post
  before_action :find_likeable
  before_action :set_like, only: [:destroy]

  include LikesHelper

  # def create
  #   if already_liked?(@post)
  #     flash[:notice] = "You can't like this more than once"
  #   else
  #     @post.likes.create(user_id: current_user.id)
  #   end
  #   redirect_back(fallback_location: root_path)
  # end

  def new
    @like = Like.new
  end

  def create
    # prevent from liking for other users
    if already_liked?(@likeable)
      flash[:notice] = "You can't like this more than once"
    else
      @like = @likeable.likes.build(like_params)
      @like.user = current_user
      return unless @like.save
    end
    redirect_back(fallback_location: root_path)
  end

  # def destroy
  #   if !already_liked?(@post)
  #     flash[:notice] = 'Cannot unlike'
  #   else
  #     @like.destroy
  #   end
  #   redirect_back(fallback_location: root_path)
  # end

  def destroy
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_like
    @like = @likeable.likes.find(params[:id])
  end

  def like_params
    params.permit(:user_id, :likeable_id, :likeable_type)
  end

  def find_likeable
    if params[:comment_id]
      @likeable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
      @likeable = Post.find_by_id(params[:post_id])
    end
  end
end
