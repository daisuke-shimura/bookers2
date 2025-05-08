class ChatsController < ApplicationController
  before_action :conform_user, only: [:show]

  def show
    #相手
    @user = User.find(params[:id])

    rooms = current_user.user_rooms.pluck(:room_id)
    #既にチャットルームがあるか
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    if user_rooms.nil?
      #ルームを作成
      @room = Room.new
      @room.save
      #Userを追加
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end


  def create
    @chat = current_user.chats.new(chat_params)
    @chat.room_id = 
    @chat.save!
    redirect_to request.referer
  end


  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to request.referer
  end


  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end


  def conform_user
    user = User.find(params[:id])

    unless current_user.follow_by?(user) && user.follow_by?(current_user)
      redirect_to books_path
    end
  end
  
end
