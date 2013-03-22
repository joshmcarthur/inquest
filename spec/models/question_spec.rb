require 'spec_helper'

describe Question do
  
  before(:each) do
    @question = Question.new
    @question.title = "Test title"
    @question.content = "Help me with this stuff"
  end

  context "with valid attributes" do
    it "should be save-able" do
      @question.should be_valid
    end
  end

  context "with invalid attributes" do

    before(:each) do
      @question.title = ''
    end

    it "should not be save-able" do
      @question.should_not be_valid
    end
  end

  context "with an answer" do

    before(:each) do
      @answer = Answer.new
      @answer.content = "Content for answer"
      @question.answers << @answer
    end

    it "should have an answer" do
      @question.answers.should_not be_empty
    end
  end

  context "without an answer" do
    it "should not have an answer" do
      @question.answers.should be_empty
    end
  end

end
  # it { should validate_numericality_of(:points) }
  # it { should_not allow_value(nil).for(:points) }
  # it { should allow_value(DateTime.now - 1.day).for(:completed_at) }
  # it { should_not allow_value(DateTime.now + 1.day).for(:completed_at) }
  # it { should belong_to :pharmacist }
  # it { should_not allow_value(nil).for(:pharmacist) }
