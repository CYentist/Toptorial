class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @tutorials = @user.tutorials.where(:checked => true).all.sort_by {|tutorial| tutorial.get_upvotes.size}.reverse
  end
end
