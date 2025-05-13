class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    join_user = GroupUser.new
    join_user.user_id = current_user.id
    join_user.group_id = group.id
    join_user.save
    redirect_to groups_path
  end

  def destroy
    group = Group.find(params[:group_id])
    leave_user = current_user.group_users.find_by(group_id: group.id)
    leave_user.destroy
    redirect_to groups_path
  end
end
