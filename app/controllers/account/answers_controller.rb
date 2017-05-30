class Account::AnswersController < ApplicationController
  before_action :authenticate_user!
  layout "account"

  def index
    @answers = current_user.answers
    @orders = current_user.orders.order("id DESC")
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to account_answers_path, notice: "答疑服务上架成功"
    else
      render :new
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to account_answers_path
    else
      render :edit
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to account_answers_path, alert: "删除了答疑服务"
  end


  private

  def answer_params
    params.require(:answer).permit(:title, :description, :contact, :price, :public)
  end
end
