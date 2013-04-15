require 'spec_helper'

describe Question do
  fixtures :questions
  fixtures :tags

  let(:tag) { tags(:test) }
  let(:five_tags ) { [ tags(:test), tags(:test2), tags(:test3), tags(:test4), tags(:test5)] }

  subject do
    question = questions(:test)
    question
  end

  context "with valid attributes" do
    it { should be_valid }
    describe "1 to 5 tags" do
      context "one existing tag in tags_list" do
        before do
          subject.tags_list = tag.name
        end

        it "should have the tags" do
          subject.tags.should == [tag]
        end
      end

      context "5 existing tag in tags_string" do
        before do
          five_tags
          subject.tags_list = five_tags.map(&:name).join(',')
        end

        it  "should have the tags" do
          subject.tags.should == five_tags
        end
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
