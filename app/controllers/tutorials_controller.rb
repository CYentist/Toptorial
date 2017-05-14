class TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :buy, :paid]

  def index
    @tutorials = Tutorial.where(:checked => true)
  end

  def new
    @tutorial = Tutorial.new
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中，暂时无法查看。"
      redirect_to root_path
    end
    @comments = @tutorial.comments.order('created_at DESC')
    @comment = Comment.new
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.user = current_user
    if @tutorial.save
      flash[:notice] = "新建成功，请等待审核。"
      current_user.buy!(@tutorial)
      redirect_to  account_tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
    find_tutorial_and_check_permission
  end

  def update
    find_tutorial_and_check_permission
    if @tutorial.update(tutorial_params)
      flash[:notice] = "修改成功，已重新上架。"
      redirect_to account_tutorial_path(@tutorial)
    else
      render :edit
    end
  end

  def destroy
    flash[:alert] = "教程已上架，不得删除"
    # find_tutorial_and_check_permission
    # @tutorial.destroy
    # flash[:alert] = "成功删除"
    # redirect_to tutorials_path
  end

  def buy
    @tutorial = Tutorial.find(params[:id])

    if !current_user.is_buyer?(@tutorial)
      current_user.buy!(@tutorial)
      flash[:notice] = "购买成功！"
    else
      flash[:warning] = "你已经购买了这个教程！"
    end

    redirect_to tutorial_path(@tutorial)
  end

  def paid
    @tutorials = current_user.paid_tutorials.where(:checked => true)
  end


  private

  def find_tutorial_and_check_permission
    @tutorial = Tutorial.find(params[:id])

    if current_user != @tutorial.user
      redirect_to root_path, alert: "你没有权限！"
    end
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :content, :user_id, :checked, :description, :image)
  end
end
