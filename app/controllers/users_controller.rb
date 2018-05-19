class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
      @users = User.all
      @incoming = FriendRequest.where(friend: current_user)
      @outgoing = current_user.friend_requests
  end
end
