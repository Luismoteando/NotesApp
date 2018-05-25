class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :user_notes
  has_many :notes, through: :user_notes

  has_many :user_collections
  has_many :collections, through: :user_collections

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  cattr_accessor :current_user

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def remove_friend(friend)
    User.current_user.friends.destroy(friend)
  end

  def set_default_role
    self.role = "user"
  end

  def set_admin_role
    self.role = "admin"
  end
end
