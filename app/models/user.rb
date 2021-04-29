class User < ApplicationRecord
  authenticates_with_sorcery!
  
  validates :email, presence: true
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  
  def already_liked?(review) #ユーザーがすでに投稿に対していいねしているか判定
    self.likes.exists?(review_id: review.id)
  end
end
