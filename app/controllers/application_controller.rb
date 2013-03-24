
class Inquest::MustOwnQuestionException < Exception
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  rescue_from Inquest::MustOwnQuestionException do
    redirect_to @question, :notice => 'You must have created this question to mark an answer as accepted
    ', :status => :bad_request
  end

  private

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end

