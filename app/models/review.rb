class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  validates :content, {presence: true, length: {maximum: 50} }
  
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
end
