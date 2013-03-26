
class Inquest::MustOwnQuestionException < Exception
end

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery
  layout :layout_by_resource
  before_filter :set_search

  rescue_from Inquest::MustOwnQuestionException do
    redirect_to @question, :notice => 'You must have created this question to mark an answer as accepted
    ', :status => :bad_request
  end

  private

  # Private: Create a ransack search object every time we render the page.
  #
  # FIXME: Replace with something more powerful
  #
  # This method is a best-at-the-moment way of making sure we can have the search form in the
  # header of the page, by creating the @search object the ransack form needs for
  # every request.
  #
  # Returns a Ransack search object
  def set_search
    @search ||= Question.search(params[:q])
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end

