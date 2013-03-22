require 'spec_helper'

describe QuestionsController do

  context "when I am not logged in" do
    it "should require an authenticated user" do
      get :index 
      response.should redirect_to new_user_session_path
      flash[:alert].should_not be_blank
    end
  end

  context "when I am logged in" do
    before do
      sign_in User.create(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')
    end

    describe "GET index" do
      before do
        get :index
      end

      it "should render the index template" do
        response.should render_template :index
      end

      it "should instantiate a collection of questions" do
        assigns(:questions).should eq Question.all
      end
    end
  end
end
