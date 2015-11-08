class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :current_user_find_group_by_id, only: [:new, :edit, :update, :destroy]
  before_action :find_group_by_id, only: [:join, :quit]
  def index
    @groups = Group.all
  end

  def show
    # 不得使用 current_user.groups.find(params[:id])，因為這樣找不到所有應出現的Group
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
  end

  def edit
  end

  def create
    @group = current_user.groups.create(group_params)
    if @group.save
      redirect_to groups_path, notice: '新增討論版成功'
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_path, notice: '修改完成'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: '討論版已經刪除'
  end

  def join
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本討論版成功！"
    else
      flash[:warning] = "你已經是本討論版成員了！"
    end
    redirect_to group_path(@group)
  end

  def quit
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:warning] = "已退出本討論版！"
    else
      flash[:alert] = "你不是本討論版成員，怎麼退出 XD"
    end
    redirect_to group_path(@group)
  end

  private
  def group_params
    params.require(:group).permit(:title, :description)
  end

  private
  def current_user_find_group_by_id
    @group = current_user.groups.find(params[:id])
  end

  private
  def find_group_by_id
    @group = Group.find(params[:id])
  end
end
