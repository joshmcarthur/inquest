class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js, :json

  def index
    @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
    @search = Question.search(params[:q])
    @questions = @search.result(:distinct => true).order('updated_at DESC').page(params[:page])
  end

  def show
    @question = Question.find(params[:id])
    @answer = current_user.answers.build
    @question_comments = @question.comments
    @comment = Comment.new
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.create(question_params)
    respond_with @question
  end

  def update
    @question = current_user.questions.find(params[:id])
    @question.update_attributes(question_params)
    respond_with @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :state, :tags_string)
  end
end
