class AnswersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js, :json

  def new
    @answer = current_user.answers.build 
  end

  def create
    @answer = current_user.answers.create(question_params)
    respond_with @answer
  end

  private

  def answer_params
    params.require(:question).permit(:content, :question_id)
  end
end
