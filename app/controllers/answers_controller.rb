class AnswersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js, :json

  before_filter :find_question

  def new
    @answer = current_user.answers.build 
  end

  def create
    @answer = @question.answers.create(answer_params)

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content).merge(:user_id => current_user.id)
  end
end
