class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  layout "account"

  def index
    @order = current_user.paid_orders
  end

  def show
    @order = Order.find_by_token(params[:id])

    # if current_user.is_asker?(@order)
    # else
    #   redirect_to root_path, alert: "你没有权限！"
    # end

  end

  def paid
    @orders = current_user.paid_orders.order("id DESC")
  end

end
