require 'spec_helper'

describe AnswersController do
  fixtures :users, :questions, :answers

  context "when I am logged in" do
    before do
      sign_in users(:tester)
    end

    describe "PUT accept" do

      context "user is not the creator of the question" do
        before do
          sign_in users(:answerer)
        end

        it "should only be acceptable by the user who created the question" do
          put :accept, :question_id => questions(:test), :id => answers(:test).id
          response.should_not be_ok
        end
      end

      context "question creator is logged in" do
        before do
          put :accept, :question_id => questions(:test), :id => answers(:test).id
        end

        it "should set an accepted answer" do
          questions(:test).accepted_answer.should eq answers(:test)
        end

        it "should redirect to the question page" do
          response.should redirect_to questions(:test)
        end

        it "should set a success message" do
          flash[:notice].should_not be_blank
        end
      end
    end

    describe "POST create" do
      context "correct attributes are provided" do
        before do
          post :create, :question_id => questions(:test).id, :answer => {:content => 'answer'}
        end

        it "should redirect to the question page" do
          response.should redirect_to questions(:test)
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

        it "should render the question show page" do
          response.should render_template "questions/show"
        end
      end
    end
  end
end
