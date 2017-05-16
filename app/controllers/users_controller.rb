class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def charge
    @user = User.find(params[:id])
    @user.point = @user.point + params[:p].to_i
    if @user.save
      redirect_to :back
    else
      flash[:alert] = "充值未成功！"
    end
  end
end
