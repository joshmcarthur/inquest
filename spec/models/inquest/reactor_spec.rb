require 'spec_helper'

describe Inquest::Reactor do
  subject do
    Inquest::Reactor
  end

  it "should have a react! method" do
    subject.methods.should include :react!
  end

  it "should raise an error if react! is called directly on the reactor" do
    expect {
      subject.react!
    }.to raise_error
  end

  it "should have a reaction description method" do
    subject.methods.should include :reaction_description
  end

  it "should raise an error if reaction_description is called directly on the reactor" do
    expect {
      subject.reaction_description
    }.to raise_error
  end
end