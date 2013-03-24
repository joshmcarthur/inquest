require 'spec_helper'

describe Question do
  fixtures :questions
  fixtures :tags

  let(:tag) { tags(:test) }

  subject do
    question = questions(:test)
    question
  end

  context "with valid attributes" do
    it { should be_valid }

    context "one existing tag in tags_string" do
      before do
        subject.tags_string = "#{tag.title}"
        subject.valid? # to trigger the validate_existing_of_tags
      end

      it  "should have the tags" do
        subject.tags.should == [tag]
      end
    end

  end

  describe "with invalid attributes" do

    context "empty title" do
      before(:each) do
        subject.title = ''
      end
      it { should_not be_valid }
    end

    context "with non-existing tag" do
      before(:each) do
        subject.tags_string = 'non-existing-tag'
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
