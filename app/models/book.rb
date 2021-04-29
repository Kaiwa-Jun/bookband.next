class Book < ApplicationRecord
  self.primary_key = "isbn" #isbnでデータを一意に識別
  has_many :reviews, dependent: :destroy #親モデルに紐づく子モデルも削除できる。ex)ユーザ退会でコメントも消える
end
