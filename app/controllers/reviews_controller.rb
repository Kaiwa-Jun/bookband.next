class ReviewsController < ApplicationController
  def index
    @book = Book.find_by(isbn: params[:isbn]) #createのindexアクションへのリダイレクトでisbnという名前でbook_id渡すためparams[:isbn]
    @reviews = @book.reviews.order(created_at: "DESC") #更新順に表示
    @ranks = Review.find(Like.group(:review_id).order('count(review_id) DESC').pluck(:review_id)) #いいね多い順に表示
  end
  
  def new
    @book = Book.find_by(isbn: params[:book_id])
    @review = Review.new
  end
  
  def show
    @review = Review.find(params[:id])
    @book = @review.book
  end

  def create
    @book = Book.find_by(isbn: params[:book_id])
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to reviews_path(isbn: params[:book_id]), notice: 'レビューに成功しました'
    else
      flash.now[:danger] = 'レビューに失敗しました'
      render :new
    end
  end
  
  private
    def review_params
      params.require(:review).permit(:content, :book_id)
    end
end
