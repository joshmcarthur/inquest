require 'spec_helper'

describe VotesController do
  fixtures :users, :questions, :answers

  let(:user) { users(:tester) }
  let(:question) { questions(:test) }
  let(:answer) { answers(:test) }

  before do
    user.votes.delete_all
    sign_in user 
  end

  describe "POST create" do
    context "voting on question" do
      before do
        post :create, :question_id => question.id, :direction => 'up'
      end

      it "should create a vote on the question" do
        question.votes.should include assigns(:vote)
      end

      it "should assign the question to @voteable" do
        assigns(:voteable).should eq question
      end

      it "should redirect to the question page" do
        response.should redirect_to question
      end

      it "should set a success message" do
        flash[:notice].should_not be_blank
      end
    end

    context "voting on answer" do
      before do
        post :create, :question_id => question.id, :answer_id => answer.id, :direction => 'up'
      end

      it "should create a vote on the answer" do
        answer.votes.should include assigns(:vote)
      end

      it "should assign the answer to @voteable" do
        assigns(:voteable).should eq answer
      end

      it "should redirect to the question page" do
        response.should redirect_to question
      end

      it "should set a success message" do
        flash[:notice].should_not be_blank
      end
    end
  end
end
