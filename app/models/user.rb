class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true, confirmation: { case_sensitive: true }, :length => {:within => 6..40}
  validates_confirmation_of :password
  validates :first_name, presence: true, :length => {:within => 2..30}
  validates :last_name, presence: true, :length => {:within => 2..30}
  validates :description, presence: true, length: { minimum: 20 }
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :age, presence: true, numericality: { message: "%{value} seems wrong" }
  belongs_to :city, optional: true
  has_many :gossips
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessageRecipient"
  has_many :comments, foreign_key: 'author_id', class_name: "Comment"

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end
end
