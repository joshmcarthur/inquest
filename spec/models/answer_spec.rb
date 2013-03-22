require 'spec_helper'

describe Answer do

  before(:each) do
    @answer = Answer.new
    @answer.content = "Help for you"
  end

  context "with valid attributes" do
    it "should be save-able" do
      @answer.should be_valid
    end
  end

  context "with invalid attributes" do

    before(:each) do
      @answer.content = ''
    end

    it "should not be save-able" do
      @answer.should_not be_valid
    end
  end
end
