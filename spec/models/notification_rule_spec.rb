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
    subject.reactor_class = nil
    subject.should_not be_valid
  end

  it "should not be valid when an invalid reactor class is present" do
    subject.reactor_class = "Unknown"
    subject.should_not be_valid
  end

  it "should find the reactor class when a valid reactor name is provided" do
    subject.reactor_class = "EmailReactor"
    subject.reactor.should be_a EmailReactor
  end
end
