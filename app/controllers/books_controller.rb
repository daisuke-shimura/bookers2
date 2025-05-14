class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
     @hon = Book.new(book_params)
     @hon.user_id = current_user.id

     if @hon.save
      flash[:notice] = "Book was successfully created."
      #@hon = book.new(book_params)
      redirect_to book_path(@hon.id)
     else
      #flash[:notice] = "失敗しちゃったよ"
      @books = Book.all.order(params[:sort])
      @book = Book.new
      render :index
     end
  end

  def index
    if params[:category].present?
      @books = Book.where(tag: params[:category])
    else
      @books = Book.all.order(params[:sort])
    end

    @book = Book.new
    @hon = Book.new #エラー用
  end

  def show
    @book = Book.find(params[:id])
    @book_user = @book.user
    #@books = Book.all
    @book_comment = BookComment.new
  end

  def edit
    is_match_login_user
    @book = Book.find(params[:id])
    @hon = Book.find(params[:id]) #エラー用
  end

  def update
    is_match_login_user
    @hon = Book.find(params[:id])

    if @hon.update(book_params)
      @book = Book.find(params[:id])
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      #flash[:notice] = "Book was not successfully updated"
      @book =  Book.find(params[:id])
      render :edit

    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    if @book.destroy
      flash[:notice] = "Book was successfully delete."
      redirect_to books_path
    else
      flash[:notice] = "消せなかったよ"
      redirect_to books_path
    end

  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :image, :star, :tag)
    end

  def is_match_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to "/books"
    end
  end


end
