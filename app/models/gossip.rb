class Gossip < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 14}
  validates :content, presence: true, length: {minimum: 3, maximum: 300}
  belongs_to :user
  has_and_belongs_to_many :tags, through: :gossips_tags
  has_many :comments
  has_many :likes, as: :writable
end
