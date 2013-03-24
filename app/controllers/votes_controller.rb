class VotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_voteable

  def create
    @vote = current_user.votes.build(:voteable => @voteable, :direction => params.fetch(:direction, 'up'))

    if @vote.save
      redirect_to voteable_path, :notice => 'Vote created!'
    else
      redirect_to voteable_path, :error => 'Could not vote. Please try again.'
    end
  end

  private

  def voteable_path
    @voteable.is_a?(Answer) ? @voteable.question : @voteable
  end

  def find_voteable
    @voteable = if params.has_key?(:answer_id)
      Question.find(params[:question_id]).answers.find(params[:answer_id])
    elsif params.has_key?(:question_id)
      Question.find(params[:question_id])
    else
      ActiveRecord::RecordNotFound
    end
  end
end
