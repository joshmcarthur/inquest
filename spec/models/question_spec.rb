require 'spec_helper'

describe Question do
  fixtures :questions

  subject do
    question = questions(:test)
    question
  end

  context "with valid attributes" do
    it { should be_valid }
  end

  describe "with invalid attributes" do

    context "empty title" do
      before(:each) do
        subject.title = ''
      end
      it { should_not be_valid }
    end


  end

  it "should have answers" do
    expect {
      subject.answers << Answer.new
    }.to change(subject.answers, :size).by(1)
  end

  it "should update the state updated timestamp when the state is changed" do
    expect {
      subject.state = "closed"
      subject.save
    }.to change(subject, :state_last_updated)
  end
end
