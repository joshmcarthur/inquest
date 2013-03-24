require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the VotesHelper. For example:
#
# describe VotesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe VotesHelper do
  fixtures :users, :votes, :answers

  let(:user) { users(:tester) }
  let(:voteable) { answers(:test) }

  before do
    helper.stub(:current_user).and_return(user)
    helper.current_user.votes.delete_all
  end

  describe "#vote_button" do
    context "current user has not voted" do
      subject do
        helper.vote_button(voteable, 'up')
      end

      it "should return the correct directional icon" do
        subject.should include "<i class=\"icon-arrow-up"
      end

      it "should have a link to vote" do
        subject.should include question_answer_votes_path(voteable.question, voteable, :direction => 'up')
      end
    end

    context "current user has voted" do
      before do
        Vote.create(:voteable => voteable, :user => user, :direction => 'up')
      end

      subject do
        helper.vote_button(voteable, 'up')
      end

      it "should not have a link to vote" do
        subject.should_not include question_answer_votes_path(voteable.question, voteable, :direction => 'up')
      end

      it "should be 'active' (not disabled)" do
        subject.should_not include "<span class=\"vote_button disabled\">"
      end
    end

    context "current user has voted, but not in this direction" do
      before do
        Vote.create(:voteable => voteable, :user => user, :direction => 'up')
      end

      subject do
        helper.vote_button(voteable, 'down')
      end

      it "should not have a link to vote" do
        subject.should_not include question_answer_votes_path(voteable.question, voteable, :direction => 'up')
      end

      it "should be disabled" do
        subject.should include "<span class=\"vote_button disabled\">"
      end
    end
  end

  describe "#vote_score" do
    before do
      Vote.create(:voteable => voteable, :user => user, :direction => 'up')
    end

    subject do
      helper.vote_score(voteable)
    end

    it "should return the vote score for the answer" do
      subject.should include "1"
    end

    it "should be inside a heading tag" do
      subject.should include "<h4"
    end

    it "should have a class for styling" do
      subject.should include "class=\"vote-score\">"
    end
  end
end
