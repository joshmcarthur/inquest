class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_question
  before_filter :require_question_user!, :only => [:accept]


  def new
    @answer = current_user.answers.build 
  end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def accept
    @answer = @question.answers.find(params[:id])
    if @answer.accept!
      @answer.create_activity :key => 'answer.accepted', :owner => current_user
      redirect_to @question, :notice => 'Answer marked as accepted!'
    else
      redirect_to @question, :notice => 'Answer could not be marked as accepted, please try again.'
    end
  end


  private

  def require_question_user!
    raise Inquest::MustOwnQuestionException unless current_user == @question.user
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content).merge(:user_id => current_user.id)
  end
end
