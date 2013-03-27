require 'spec_helper'

describe NotificationRule do
  fixtures :notification_rules

  subject do
    notification_rules(:test)
  end

  it "should be valid when all required attributes are present" do
    subject.should be_valid
  end

  it "should not be valid when a vital attribute is missing" do
    subject.reactor_name = nil
    subject.should_not be_valid
  end

  it "should not be valid when an invalid reactor class is present" do
    subject.reactor_name = "Unknown"
    subject.should_not be_valid
  end

  it "should find the reactor class when a valid reactor name is provided" do
    subject.reactor_name = "EmailReactor"
    subject.reactor.should eq EmailReactor
  end
end
