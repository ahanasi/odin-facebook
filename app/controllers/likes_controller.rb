class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]

  include LikesHelper

  def create
    if already_liked?(@post)
      flash[:notice] = "You can't like this more than once"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if !already_liked?(@post)
      flash[:notice] = 'Cannot unlike'
    else
      @like.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find(params[:id])
  end
end
