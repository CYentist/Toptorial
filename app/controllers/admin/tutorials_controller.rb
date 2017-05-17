class Admin::TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :new, :create, :update, :edit, :destroy]
  before_action :require_is_admin

  layout "admin"

  def index
    @tutorials = case params[:order]
    when 'checked'
      Tutorial.checked
    when 'unchecked'
      Tutorial.unchecked
    else
      Tutorial.all
    end
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
      redirect_to admin_tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    if @tutorial.update(tutorial_params)
      redirect_to admin_tutorial_path(@tutorial)
      flash[:notice] = "修改成功"
    else
      render :edit
    end
  end

  def destroy
    @tutorial = Tutorial.find(params[:id])
    @tutorial.destroy
    flash[:alert] = "成功删除"
    redirect_to admin_tutorials_path
  end

  def check
    @tutorial = Tutorial.find(params[:id])
    @tutorial.check!
    flash[:notice] = "该课程已通过审核，公开上架。"
    redirect_to :back
  end

  def recheck
    @tutorial = Tutorial.find(params[:id])
    @tutorial.recheck!
    flash[:alert] = "该课程已下架，等待重新审核。"
    redirect_to :back
  end


  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :content, :user_id, :checked, :description, :image, :price)
  end
end
