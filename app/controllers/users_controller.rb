class UsersController < ApplicationController
  before_action :set_user, only: %i[show posts friends requests]
  def show
    @posts = @user.posts.sort_by { |e| e[:updated_at] }.reverse!
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.with_attached_avatar.find(params[:id])
  end
end
