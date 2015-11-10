class Account::GroupsController < ApplicationController

  before_action :authenticate_user!

  def index
    @groups = current_user.participated_groups.order("posts_count DESC") #這是什麼
  end
end
