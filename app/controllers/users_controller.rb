class UsersController < ApplicationController
  before_action :set_user, only: %i[show posts friends requests]
  def show
    @posts = @user.posts.sort_by { |e| e[:updated_at] }.reverse!
  end

  def posts
    @posts = @user.posts.sort_by { |e| e[:updated_at] }.reverse!
  end

  def friends; end

  def requests; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
