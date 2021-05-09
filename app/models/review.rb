class Review < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  belongs_to :book, primary_key: "isbn"
  validates :content, {presence: true, length: {maximum: 50} }
  
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
　
    old_tags.each do |old|
      self.review_tags.delete ReviewTag.find_by(tag_name: old)
    end
　
    new_tags.each do |new|
      new_review_tag = ReviewTag.find_or_create_by(tag_name: new)
      self.review_tags << new_review_tag
    end
  end
end
