require 'spec_helper'

describe User do
  let(:user) { User.new(
                :email => 'tester@example.com', 
                :password => 'password1', 
                :password_confirmation => 'password1'
              )
  }
  context "with valid attributes" do
    it "should be valid" do
      user.should be_valid
    end
  end

  context "with missing attributes" do
    before do
      user.password = ""
    end
    
    it "should not be valid" do
      user.should_not be_valid
    end
  end

end
