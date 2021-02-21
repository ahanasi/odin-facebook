class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  def show
    @posts = @user.posts.with_attached_image.sort_by { |e| e[:updated_at] }.reverse!
    @photos = @user.photos.sort_by { |e| e[:created_at] }.reverse!
  end

  def index
    @users = User.all_except(current_user).with_attached_avatar
    @user = current_user
  end

  def posts
    @posts = @user.posts.sort_by { |e| e[:updated_at] }.reverse!
  end

  def friends
    @disable_friends_sidebar = true
  end

  def requests
    (redirect_to root_path, alert: "That Page Isn't Available") unless @user == current_user
  end

  def liked_posts
    @posts = @user.liked_posts.sort_by { |e| e[:updated_at] }.reverse!
  end

  def photos
    @photos = @user.photos.sort_by { |e| e[:created_at] }.reverse!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.with_attached_avatar.find(params[:id])
  end
end
