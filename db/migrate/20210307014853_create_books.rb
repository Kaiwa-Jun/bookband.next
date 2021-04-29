class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books, id: false do |t| #idでなくISBNで
      t.string :title
      t.string :author
      t.bigint :isbn, null: false, primary_key: true
      t.string :url
      t.string :image_url
      t.string :book_genre_id

      t.timestamps
    end
    
  end
end
