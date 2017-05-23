class TutorialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :upvote, :downvote, :buy, :paid]
  before_action :validate_search_key, only: [:search]

  def index
    @tutorials = case params[:order]
    when 'by_votes'
      Tutorial.checked.order(:cached_votes_up => :desc).paginate(page: params[:page], per_page: 9)
    when 'by_time'
      Tutorial.checked.recent.paginate(page: params[:page], per_page: 9)
    else
      Tutorial.checked.order(:cached_votes_up => :desc).paginate(page: params[:page], per_page: 9)
    end
    render layout: "welcome"
  end

  def new
    @tutorial = Tutorial.new
    @photos = current_user.photos
  end

  def show
    @tutorial = Tutorial.find(params[:id])
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中，暂时无法查看。"
      redirect_to root_path
    end
    if !current_user || !current_user.is_buyer?(@tutorial)
      redirect_to preview_tutorial_path(@tutorial)
    end
    @comments = @tutorial.comments.order('created_at DESC')
    @comment = Comment.new
  end

  def preview
    @tutorial = Tutorial.find(params[:id])
    if !@tutorial.checked
      flash[:warning] = "此教程正在审核中，暂时无法查看。"
      redirect_to root_path
    end
    @comments = @tutorial.comments.order('created_at DESC')
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
    @photos = current_user.photos
  end

  def update
    find_tutorial_and_check_permission
    if @tutorial.update(tutorial_params)
      if @tutorial.checked
        flash[:notice] = "修改成功，已重新上架。"
      else
        flash[:notice] = "修改成功，请等待审核。"
      end
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
      if current_user.point >= @tutorial.price
        current_user.point = current_user.point - @tutorial.price
        current_user.save
        @tutorial.user.point = @tutorial.user.point + @tutorial.price
        @tutorial.user.save
        current_user.buy!(@tutorial)
        redirect_to tutorial_path(@tutorial)
        flash[:notice] = "购买成功！"
      else
        redirect_to account_user_path(current_user)
        flash[:alert] = "您的余额不足，请充值。"
      end
    else
      redirect_to tutorial_path(@tutorial)
      flash[:warning] = "你已经购买了这个教程！"
    end
  end

  def paid
    @tutorials = current_user.paid_tutorials.where(:checked => true)
    render layout: "account"
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
    params.require(:tutorial).permit(:title, :content, :user_id, :checked, :description, :image, :price)
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
