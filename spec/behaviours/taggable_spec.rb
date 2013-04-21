require 'spec_helper'

describe 'Tagging' do
  fixtures :tags, :questions

  subject do
    questions(:test)
  end

  before do
    questions(:test).tags.clear
  end

  it { should respond_to :tags }

  describe ".tags_list" do
    before do
      subject.tags << [tags(:test), tags(:test2)]
    end

    it "should return an array of tag strings" do
      subject.tags_list.should have(2).strings
    end
  end

  describe ".tags_list=" do
    before do
      subject.tags << tags(:test)
    end

    it "should add a tag to the tag list" do
      expect {
        subject.tags_list = tags(:test3).name
      }.to change(subject.tags, :count).by(1)
    end

    it "should not re-add a tag that already exists" do
      expect {
        subject.tags_list = tags(:test).name
      }.to_not change(subject.tags, :count)
    end

    it "should not add an unknown tag" do
      expect {
        subject.tags_list = "unknown"
      }.to_not change(subject.tags, :count)
    end
  end

  describe "tagged_with?" do
    before do
      subject.tags << tags(:test)
    end

    it "should return true if the tag exists in the tags list" do
      subject.tagged_with?(tags(:test)).should be_true
    end

    it "should return false if the tag does not exist in the tags list" do
      subject.tagged_with?(tags(:test2)).should_not be_true
    end
  end
end
