require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AnswersHelper. For example:
#
# describe AnswersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AnswersHelper do
  fixtures :questions, :users, :answers

  let(:question) { questions(:test) }

  describe "#accept_answer_link" do
    context "question is owned by current user and is not accepted" do
      before do
        helper.stub(:current_user).and_return(users(:tester))
        @output = helper.accept_answer_link(answers(:test))
      end

      it "should have a link to accept the answer" do
        @output.should include accept_question_answer_path(question, answers(:test))
      end

      it "should render the accepted icon" do
        @output.should include "class=\"icon-ok-sign icon-3x\""
      end
    end

    context "question already has accepted answer" do
      before do
        helper.stub(:current_user).and_return(users(:tester))
        answers(:test).accept!
        @output = helper.accept_answer_link(answers(:another_test))
      end

      it "should not have a link to accept the answer" do
        @output.should_not include accept_question_answer_path(question, answers(:another_test))
      end

      it "should not render the accepted icon" do
        @output.should_not include "class=\"icon-ok-sign icon-3x\""
      end
    end

    context "question is not owned by the current user but is accepted" do
      before do
        helper.stub(:current_user).and_return(users(:answerer))
        answers(:test).accept!
        @output = helper.accept_answer_link(answers(:test))
      end

      it "should not have a link to accept the answer" do
        @output.should_not include accept_question_answer_path(question, answers(:test))
      end

      it "should render the accepted icon" do
        @output.should include "class=\"icon-ok-sign icon-3x\""
      end
    end
  end
end
