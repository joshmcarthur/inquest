require 'spec_helper'

describe Answer do
  fixtures :answers
  fixtures :users
  fixtures :questions

  subject do
    answers(:test)
  end

  it { should be_valid }
  it { subject.user.should be_a User }
  it { subject.question.should be_a Question }

  context "with invalid attributes" do
    before do
      subject.content = ""
    end

    it { should_not be_valid }
  end

  describe "#accept!" do
    it "should update the accepted at attribute" do
      expect {
        subject.accept!
      }.to change(subject, :accepted_at)
    end
  end
end
