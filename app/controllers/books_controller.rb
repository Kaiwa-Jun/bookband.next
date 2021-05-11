class BooksController < ApplicationController
  def search
    @books = [] #空の配列。APIから取得したJSONデータをここに格納
    @title = params[:title]
    
    genre = RakutenWebService::Books::Genre.search({ booksGenreId: '001' })
    @genres = genre.first["children"].map{|v| {
      id: v["booksGenreId"],
      name: v["booksGenreName"]
    }}
    
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })
      results.each do |result| #@booksにAPIから取得したデータを格納。
        book = Book.new(read(result)) #read(result)は下記privateで絞り込んだAPIデータを@booksに格納
        @books << book
      end
    
      @books.each do |book| #@book内のデータを格納
        unless Book.all.include?(book) #unlessで既に保存した本は除外する
          book.save
        end
      end
    end
    
    if params[:book_genre_id]
      @books = Book.where('book_genre_id like ?', "#{params[:book_genre_id]}%")
    end
  end
  
      # binding.pry
  
  private #class内でのみアクセス可能
  def read(result) #楽天APIから取得したデータの絞り込み（タイトル、著者名、URL、ISBN、画像、ジャンル、商品説明）
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"]#.gsub('?_ex=120x120', '') 
    book_genre_id = result["booksGenreId"] #ジャンル
    {
      title: title, #ハッシュ。対応するカラムにデータを格納？
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      book_genre_id: book_genre_id,
    }
  end

end
