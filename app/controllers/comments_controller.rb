class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comments = @tutorial.comments.order('created_at DESC')
  end

  def new
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comment = Comment.new
  end

  def create
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comment = Comment.new(comment_params)
    @comment.tutorial = @tutorial
    @comment.user = current_user

    if @comment.save
      redirect_to tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment = @comment.update(comment_params)
  end

  def destroy
    @tutorial = Tutorial.find(params[:tutorial_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:alert] = "成功删除评论"
    redirect_to tutorial_path(@tutorial)
  end


    private

    def comment_params
      params.require(:comment).permit(:post, :user_id, :tutorial_id)
    end


end
