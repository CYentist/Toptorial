class AnswersController < ApplicationController
  def checkout
    @order = Order.new
  end
end
