class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :book, null: false
      t.references :user, null: false, foreign_key: true #外部キー設定
      t.text :content

      t.timestamps
    end
    
    add_index :reviews,[:user_id, :book_id]
  end
end
