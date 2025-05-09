class UsersController < ApplicationController

  before_action :is_match_login_user, only:[:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @hon = Book.new #エラー用
    #投稿数 計測
    @today_books = @books.created_today
    @yesterday_books = @books.created_one_ago
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week

    #7日分の投稿数
    @two_ago_books = @books.created_two_ago
    @three_ago_books = @books.created_three_ago
    @four_ago_books = @books.created_four_ago
    @five_ago_books = @books.created_five_ago
    @six_ago_books = @books.created_six_ago 
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
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

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new

    if params[:created_at] == ""
      @search_book = "日付を選択してね"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def is_match_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end



end
