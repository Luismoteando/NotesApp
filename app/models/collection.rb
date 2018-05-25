class Collection < ActiveRecord::Base
  has_many :notes

  has_many :user_collections
  has_many :users, through: :user_collections
end
