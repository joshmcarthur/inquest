class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_commentable

  def create
    @comment = current_user.comments.build(:content => params[:comment][:content], :commentable => @commentable)

    if @comment.save
      redirect_to commentable_path, :notice => 'Comment created!'
    else
      redirect_to commentable_path, :error => 'Could not add your comment. Please try again.'
    end
  end

  private

  def commentable_path
    @commentable.is_a?(Answer) ? @commentable.question : @commentable
  end

  def find_commentable
    @commentable = if params.has_key?(:answer_id)
      Question.find(params[:question_id]).answers.find(params[:answer_id])
    elsif params.has_key?(:question_id)
      Question.find(params[:question_id])
    else
      ActiveRecord::RecordNotFound
    end
  end
end
