require 'spec_helper'

describe ApplicationHelper do
  describe "#glyph" do
    before do
      @output = helper.glyph('user', 2)
    end

    it "should render an i tag" do
      #FIXME let's make this a regex
      @output.should include "</i>"  
    end

    it "should have the icon name as a class" do
      @output.should include "class=\"icon-user"
    end

    it "should support using the '2x' classes to change the size" do
      @output.should include "class=\"icon-user icon-2x\""
    end
  end
end