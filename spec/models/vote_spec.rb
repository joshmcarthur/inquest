require 'spec_helper'

describe Vote do
  fixtures :questions, :votes, :users

  subject do
    votes(:up_on_question)
  end

  it "should say a valid example is valid" do
    subject.should be_valid
  end

  it "should say an invalid example is invalid" do
    subject.direction = "one"
    subject.should_not be_valid
  end

end
