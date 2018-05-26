class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
    @users = User.all
    @friends = @user.friends
    @incoming = FriendRequest.where(friend: @user)
    @outgoing = @user.friend_requests
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def promote
    @user.set_admin_role
    if @user.save
      redirect_to request.referrer
    end
  end

  def unpromote
    @user.set_default_role
    if @user.save
      redirect_to request.referrer
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
