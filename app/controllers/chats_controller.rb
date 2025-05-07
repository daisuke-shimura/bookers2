class ChatsController < ApplicationController
  before_action :conform_user, only: [:show]

  def show
    
  end


  def create
    
  end


  def destroy
    
  end


  private
  def chat_params
    params.require(:chat).permit(:message)
  end


  def conform_user
    user = User(params[:id])

    unless current_user.follow_by?(user) && user.follow_by?(current_user)
      redirect_to books_path
    end
  end
  
end
