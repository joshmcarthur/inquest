require 'spec_helper'

describe Tag do
  fixtures :tags

  subject do
    Tag.new
  end

  it "should be valid" do
    subject.name = "New tag"
    subject.should be_valid
  end

  # TODO passing specs
  it "should require a name" do
    subject.name = ""
    subject.valid?
    subject.errors[:name].should_not be_blank
  end

  it "should require a unique name" do
    subject.name = tags(:test).name
    subject.valid?
    subject.errors[:name].should_not be_blank
  end
end
