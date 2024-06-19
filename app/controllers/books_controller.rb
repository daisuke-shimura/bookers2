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
      @books = Book.all
      @book = Book.new
      render :index
     end
  end

  def index
    @books = Book.all
    @book = Book.new
    @hon = Book.new #エラー用
    @user = current_user.id
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user.id
  end

  def edit
    @book = Book.find(params[:id])
    @hon = Book.find(params[:id]) #エラー用
  end

  def update
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
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = "消せなかったよ"
      redirect_to user_path(current_user.id)
    end

  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :image)
    end


end
