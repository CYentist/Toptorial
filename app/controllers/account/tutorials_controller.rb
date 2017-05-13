class Account::TutorialsController < ApplicationController

  def index
    @tutorials = current_user.tutorials
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    if current_user != @tutorial.user
      redirect_to root_path, alert: "你没有权限！"
    end
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中"
    end
  end

end
