require 'spec_helper'

describe User do
  fixtures :users

  subject do
    users(:tester)
  end

  context "with valid attributes" do
    it { should be_valid }
  end

  context "with missing attributes" do
    before do
      subject.password = ""
    end
    
    it { should_not be_valid }
  end

  it "should have questions" do
    expect {
      subject.questions << Question.new
    }.to change(subject.questions, :size).by(1)
  end

 
  it "should have answers" do
    expect {
      subject.answers << Answer.new
    }.to change(subject.answers, :size).by(1)
  end

end
