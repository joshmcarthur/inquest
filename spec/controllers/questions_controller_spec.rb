require 'spec_helper'

describe QuestionsController do

  context "when I am not logged in" do
    it "should require an authenticated user" do
      get :index 
      response.should redirect_to new_user_session_path
      flash[:alert].should_not be_blank
    end
  end

end
