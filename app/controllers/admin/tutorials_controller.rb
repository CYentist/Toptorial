class Admin::TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin

  def index
    @tutorials = Tutorial.all
  end

  def new
    @tutorial = Tutorial.new
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.user = current_user
    if @tutorial.save
      flash[:notice] = "成功发布教程"
      redirect_to  tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    @tutorial = Tutorial.find(params[:id])

    if @tutorial = Tutorial.update(tutorial_params)
      redirect_to tutorial_path(@tutorial)
      flash[:notice] = "修改成功"
    else
      render :edit
    end
  end

  def destroy

    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    flash[:alert] = "成功删除"
    redirect_to tutorials_path
  end


  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :content, :user_id)
  end
end
