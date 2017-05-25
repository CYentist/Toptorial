class AnswersController < ApplicationController


  def ask
    @answer = Answer.find(params[:id])
    @order = Order.new
    current_cart.answer = @answer
    current_cart.save
  end



end
