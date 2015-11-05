class PostsController < ApplicationController
  before_action :find_group, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def new
    @post = @group.posts.new
  end

  def edit
    @post = @group.posts.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)

    if @post.save
      redirect_to group_path(@group), notice: "張貼成功！"
    else
      render :new
    end
  end

  def update
    @post = @group.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章編輯成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = @group.posts.find(params[:id])

    @post.destroy
    redirect_to group_path(@group), alert: "刪除完畢！"
  end
  
  private
  def post_params
    params.require(:post).permit(:content)
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end
end
