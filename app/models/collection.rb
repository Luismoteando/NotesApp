class Collection < ActiveRecord::Base
  has_many :user_collections
  has_many :users, through: :user_collections

  has_many :note_collections
  has_many :notes, through: :note_collections
end
