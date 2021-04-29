class AddBookGenreIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_genre_id, :string
  end
end
