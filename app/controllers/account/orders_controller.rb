class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  layout "account"

  def index
    @order = current_user.paid_orders.order("id DESC")
  end

  def show
    @order = Order.find_by_token(params[:id])

    # if current_user.is_asker?(@order)
    # else
    #   redirect_to root_path, alert: "你没有权限！"
    # end

  end

  def accept
    @order = Order.find(params[:id])
    @order.accept!
    redirect_to :back
  end

  def deliver
    @order = Order.find(params[:id])
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    redirect_to :back
  end


  def paid
    @orders = current_user.paid_orders.order("id DESC")
  end

end
