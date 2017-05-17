class Account::UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "信息更新成功"
      redirect_to :back
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def charge
    @user = User.find(params[:id])
    @user.point = @user.point + params[:p].to_i
    if @user.save
      redirect_to :back, notice:"充值成功！"
    else
      flash[:alert] = "充值未成功！"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :avatar, :description, :contact)
  end

end
