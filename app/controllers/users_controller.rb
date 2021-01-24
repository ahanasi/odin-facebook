class UsersController < ApplicationController
  before_action :set_user, only: %i[show posts]
  def show; end

  def posts
    @posts = @user.posts.sort_by{|e| e[:updated_at]}.reverse! 
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
