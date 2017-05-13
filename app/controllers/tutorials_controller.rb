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
      flash[:notice] = "新建成功，请等待审核。"
      redirect_to  account_tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    find_tutorial_and_check_permission
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中"
    end
  end

  def update
    find_tutorial_and_check_permission
    @tutorial.checked = false

    if @tutorial.update(tutorial_params)
      flash[:notice] = "修改成功，请等待审核。"
      redirect_to account_tutorial_path(@tutorial)
    else
      render :edit
    end
  end

  def destroy

    find_tutorial_and_check_permission
    @tutorial.destroy
    flash[:alert] = "成功删除"
    redirect_to tutorials_path
  end


  private

  def find_tutorial_and_check_permission
    @tutorial = Tutorial.find(params[:id])

    if current_user != @tutorial.user
      redirect_to root_path, alert: "你没有权限！"
    end
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :content, :user_id, :checked)
  end
end
