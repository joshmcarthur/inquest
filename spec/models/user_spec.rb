require 'spec_helper'

describe User do
  let(:user) { User.new(
                :email => 'tester@example.com', 
                :password => 'password1', 
                :password_confirmation => 'password1'
              )
  }
  context "with valid attributes" do
    it "should be valid" do
      user.should be_valid
    end
  end

  context "with missing attributes" do
    before do
      user.password = ""
    end
    
    it "should not be valid" do
      user.should_not be_valid
    end
  end

  context "with questions and answers" do

    before(:all) do
      question = Question.new
      question.title = "A title"
      question.content = "A questions content"
      user.questions << question

      answer = Answer.new
      answer.content = "An answer"
      user.answers << answer
    end

    it "should have questions" do
      user.questions.should_not be_empty
    end

    it "should have answers" do
      user.answers.should_not be_empty
    end

    it "should be save-able" do
      user.should be_valid
    end
  end

  context "without questions and answers" do

    it "should not have questions" do
      user.questions.should be_empty
    end

    it "should not have answers" do
      user.answers.should be_empty
    end

    it "should be save-able" do
      user.should be_valid
    end
  end

end
