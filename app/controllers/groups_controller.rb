class GroupsController < ApplicationController
  before_action :is_match_login_user, only: [:edit, :create]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    group = Group.new(group_params)
    group.owner_id = current_user.id
    group.save
    redirect_to groups_path
  end

  def destroy
  end

  def update
    group = Group.find(params[:id])
    group.update(group_params)
    redirect_to groups_path
  end


  private
  def group_params
    params.require(:group).permit(:name, :introduction, :image) 
  end

  def is_match_login_user
    group = Group.find(params[:id])
    unless group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
