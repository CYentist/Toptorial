class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tutorials = @user.tutorials.where(:checked => true).all.sort_by {|tutorial| tutorial.get_upvotes.size}.reverse
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
end
