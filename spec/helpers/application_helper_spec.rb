require 'spec_helper'

describe ApplicationHelper do
  fixtures :users

  let(:user) { users(:tester) }
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

  describe "#badge" do
    before do
      @output = helper.badge(2, "badge-test")
    end

    it "should include a span with the correct class" do
      @output.should include "<span class=\"badge"
    end

    it "should include the number passed in" do
      @output.should include ">2</span>"
    end

    it "should include a custom class" do
      @output.should include "class=\"badge badge-test"
    end
  end

  describe "#inline_user_display" do
    before do
      @output = helper.inline_user_display(user)
    end

    it "should include a link to the user" do
      @output.should include "/users/#{user.id}"
    end

    it "should include the user's gravatar" do
      # gravatar_url renders in views with & as &amp; - but in specs as
      # plain ol' &
      @output.should include user.gravatar_url(:size => 16).gsub("&", "&amp;")
    end

    it "should include the user's username" do
      @output.should include user.username
    end
  end
end