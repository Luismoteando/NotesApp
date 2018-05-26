class Note < ActiveRecord::Base
  has_many :user_notes
  has_many :users, through: :user_notes

  has_many :note_collections
  has_many :collections, through: :note_collections

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
