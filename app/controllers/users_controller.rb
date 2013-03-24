class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @questions_asked = @user.questions.page(params[:questions_asked_page]).per(3)
    @questions_answered = Question.includes({:answers => :user}).where(:answers => {:user_id => @user.id}).page(params[:questions_answered_page]).per(3)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_with_password(user_params)
      redirect_to @user
    else
      render :action => "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :current_password, :password, :password_confirmation, :email)
  end
end
