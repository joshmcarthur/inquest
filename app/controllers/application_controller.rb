class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end
