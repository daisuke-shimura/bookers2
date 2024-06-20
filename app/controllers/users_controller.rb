class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @hon = Book.new #エラー用
  end

  def edit
    is_match_login_user
    @user = User.find(params[:id])
  end

  def update
    is_match_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @hon = Book.new #エラー用
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def is_match_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to "/books"
    end
  end



end
