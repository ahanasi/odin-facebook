require 'pry'
class FriendshipsController < ApplicationController
  before_action :set_friend, only: %i[create accept decline cancel]

  def create
    Friendship.request(current_user, @friend)
    flash[:notice] = 'Friend request sent.'
    redirect_to root_path
  end

  def accept
    Friendship.accept(current_user, @friend)
    flash[:notice] = 'Friend request accepted.'
    redirect_to user_path(current_user)
  end

  def decline
    Friendship.breakup(current_user, @friend)
    flash[:notice] = 'Friend request declined.'
    redirect_to user_path(current_user)
  end

  def cancel
    Friendship.breakup(current_user, @friend)
    flash[:notice] = 'Friend request canceled.'
    redirect_to user_path(current_user)
  end

  def delete
    Friendship.breakup(@user, @friend)
    flash[:notice] = "You are not friends with #{@friend.name} anymore."
    redirect_to user_path(current_user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friend
    @friend = User.find_by_name(params[:name])
  end
end
