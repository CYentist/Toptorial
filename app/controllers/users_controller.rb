class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def charge
    @user = User.find(params[:id])
    @user.point
  end
end
