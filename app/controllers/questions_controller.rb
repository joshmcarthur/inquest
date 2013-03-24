class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js, :json

  def index
    @questions = Question.page params[:page]
  end

  def show
    @question = Question.find(params[:id])
    @answer = current_user.answers.build
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.create(question_params)
    respond_with @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
