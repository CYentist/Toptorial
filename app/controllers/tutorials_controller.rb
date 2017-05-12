class TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @tutorials = Tutorial.where(:checked => true)
  end

  def new
    @tutorial = Tutorial.new
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中"
      redirect_to root_path
    end
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
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中"
      redirect_to root_path
    end
  end

  def update
    @tutorial = Tutorial.find(params[:id])
    @tutorial.checked = false

    if @tutorial.update(tutorial_params)
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
    params.require(:tutorial).permit(:title, :content, :user_id, :checked)
  end
end
