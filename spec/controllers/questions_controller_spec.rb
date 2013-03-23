require 'spec_helper'

describe QuestionsController do
  fixtures :users

  context "when I am not logged in" do
    it "should require an authenticated user" do
      get :index 
      response.should redirect_to new_user_session_path
      flash[:alert].should_not be_blank
    end
  end

  context "when I am logged in" do
    before do
      sign_in users(:tester)
    end

    describe "GET index" do
      before do
        Question.stub(:all).and_return([Question.new, Question.new])
        get :index
      end

      it "should render the index template" do
        response.should render_template :index
      end

      it "should instantiate a collection of questions" do
        assigns(:questions).should have(2).instances_of(Question)
      end
    end
  end
end
