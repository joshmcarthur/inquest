class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @questions = Question.all
  end

  def new
  end
end
