class TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :buy, :paid]
  before_action :validate_search_key, only: [:search]

  def index
    @tutorials = Tutorial.where(:checked => true).all.sort_by {|tutorial| tutorial.get_upvotes.size}.reverse
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
    find_tutorial_and_check_permission
    if @tutorial.checked
      flash[:alert] = "教程已上架，不得删除"
    else
      @tutorial.destroy
      flash[:alert] = "成功删除"
    end
      redirect_to account_tutorials_path
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

  def upvote
      @tutorial = Tutorial.find(params[:id])
    if current_user.is_buyer?(@tutorial)
      @tutorial.upvote_by current_user
    else
      flash[:warning] = "你并未购买教程，不能投票！"
    end
      redirect_to :back
  end

  def downvote
      @tutorial = Tutorial.find(params[:id])
    if current_user.is_buyer?(@tutorial)
      @tutorial.downvote_by current_user
    else
      flash[:warning] = "你并未购买教程，不能投票！"
    end
      redirect_to :back
  end

  def search
    if @query_string.present?
      @tutorials = Tutorial.checked.ransack(@search_criteria).result(:distinct => true)
    end
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


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria =  search_criteria(@query_string)
    end
  end

  def search_criteria(query_string)
    { :title_or_content_or_description_cont => query_string }
  end
end
