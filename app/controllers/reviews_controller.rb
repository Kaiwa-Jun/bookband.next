class ReviewsController < ApplicationController
  def index
    @book = Book.find_by(isbn: params[:isbn]) #createのindexアクションへのリダイレクトでisbnという名前でbook_id渡すためparams[:isbn]
    @reviews = @book.reviews.order(created_at: "DESC") #更新順に表示
    @ranks = Review.find(Like.group(:review_id).order('count(review_id) DESC').pluck(:review_id)) #いいね多い順に表示
  end
  
  def new
    @tag_list = Tag.all
    @book = Book.find_by(isbn: params[:book_id])
    @review = Review.new
  end
  
  def show
    @review = Review.find(params[:id])
    @book = @review.book
    @review_tags = @review.tags #投稿に紐付けされるタグの取得
  end

  def create
    binding.pry
    @book = Book.find_by(isbn: params[:book_id])
    @review = current_user.reviews.new
    tag_list = params[:review][:tag_name].split(nil) #split=>送信されてきた値を、スペースで区切って配列化
    if @review.save
      @review.save_tag(tag_list)
      redirect_to reviews_path(isbn: params[:book_id]), notice: 'レビューに成功しました'
    else
      flash.now[:danger] = 'レビューに失敗しました'
      render :new
    end
  end
  
  private
    def review_params
      params.require(:review).permit(:content, :book_id, :tag_name)
    end
end
