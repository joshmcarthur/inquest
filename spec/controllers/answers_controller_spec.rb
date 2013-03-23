require 'spec_helper'

describe AnswersController do
  fixtures :users, :questions

  context "when I am logged in" do
    before do
      sign_in users(:tester)
    end

    describe "POST create" do
      context "correct attributes are provided" do
        before do
          post :create, :question_id => questions(:test).id, :answer => {:content => 'answer'}
        end

        it "should redirect to the question page" do
          response.should redirect_to assigns(:question)
        end

        it "should save the answer" do
          assigns(:answer).should be_persisted
        end

        it "should assign the created answer" do
          assigns(:answer).should be_a(Answer)
        end
      end

      context "incorrect attributes are provied" do
        before do
          post :create, :question_id => questions(:test).id, :answer => {:content => ''}
        end

        it "should assign the answer" do
          assigns(:answer).should be_a(Answer)
        end

        it "should not save the answer" do
          assigns(:answer).should_not be_persisted
        end

        it "should render the new template" do
          response.should render_template :new
        end
      end
    end
  end
end
