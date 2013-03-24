class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @questions_asked = @user.questions.page(params[:page]).per(3)
    @questions_answered = Question.includes({:answers => :user}).where(:answers => {:user_id => @user.id}).page(params[:page]).per(3)
  end
end