require "pry"
class FriendshipsController < ApplicationController
  def create
    @friend = User.find_by_name(params[:name])
    Friendship.request(current_user, @friend)
    flash[:notice] = "Friend request sent."
    redirect_to root_path
  end

  def index
  end
end
