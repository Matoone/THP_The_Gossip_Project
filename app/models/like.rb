class Like < ApplicationRecord
  belongs_to :writable, polymorphic: true
  belongs_to :user
end
