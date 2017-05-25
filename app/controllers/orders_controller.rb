class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

    def show
      @order = Order.find_by_token(params[:id])
    end

    def create
      @order = Order.new(order_params)
      @cart = current_cart
      @order.user = @cart.answer.user
      @order.total = @cart.answer.price

      if @order.save
        if current_user.point >= @order.total
          current_user.point -=  @order.total
          current_user.save
          @order.user.point +=  @order.total
          @order.user.save
          current_user.ask!(@order)
          redirect_to account_order_path(@order.token)
          flash[:notice] = "购买成功！"
        else
          redirect_to account_user_path(current_user)
          flash[:alert] = "您的余额不足，请充值。"
        end
      else
        render 'answers/ask'
      end
    end

    def pay_with_alipay
      @order = Order.find_by_token(params[:id])
      @order.set_payment_with!("alipay")
      @order.make_payment!

      redirect_to order_path(@order.token), notice: "使用支付宝成功完成付款"
    end

    def pay_with_wechat
      @order = Order.find_by_token(params[:id])
      @order.set_payment_with!("wechat")
      @order.make_payment!

      redirect_to order_path(@order.token), notice:"使用微信成功完成付款"
    end

    def apply_to_cancel
      @order = Order.find(params[:id])
      OrderMailer.apply_cancel(@order).deliver!
      flash[:notice] = "已提交申请"
      redirect_to :back
    end

      private

    def order_params
      params.require(:order).permit(:total, :user_id, :question, :contact)
    end


end
