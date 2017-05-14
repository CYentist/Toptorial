class Account::TutorialsController < ApplicationController

  def index
    @tutorials = current_user.tutorials
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    if current_user != @tutorial.user
      redirect_to root_path, alert: "你没有权限！"
    end
    @comments = @tutorial.comments.order('created_at DESC')
    @comment = Comment.new
  end

end
