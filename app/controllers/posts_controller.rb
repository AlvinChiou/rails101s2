class PostsController < ApplicationController
  before_action :find_group, only: [:new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :member_required, only: [:create, :update]
  def new
    @post = @group.posts.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group), notice: "張貼成功！"
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章編輯成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
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
  
  private
  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你不是這個討論版的成員，不能發文喔！"
      redirect_to group_path(@group)
    end
  end
end
