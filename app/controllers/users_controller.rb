class UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @users = User.all
    @friends = @user.friends
    @incoming = FriendRequest.where(friend: @user)
    @outgoing = @user.friend_requests
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
