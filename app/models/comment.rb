class Comment < ApplicationRecord
  validates :author, presence: true
  validates :content, presence: true, length: {minimum: 3, maximum: 300}
  belongs_to :author, class_name: "User"
  belongs_to :gossip
  has_many :likes, as: :writable
end
