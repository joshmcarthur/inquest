require 'spec_helper'

describe "User answers question" do
  fixtures :users, :questions
  let(:user) { users(:tester) }

  describe "answering question" do

    before(:each) do
      current_user = users(:tester)
    end

    it "should display the answer text_area"

    context "valid inputs" do
      before do
        within 'form#answer' do
          fill_in 'content', :with => 'Test answer'
          click 'Save'
        end
      end

      it "should show the new answer on the page" do
        page.should have_content 'Test answer'
      end

      it "should return a success" do
        page.should have_content 'Saved your answer'
      end
    end

    context "invalid inputs" do
      it "should return an error" do
        within 'form#answer' do
          click 'Save'
        end

        page.should have_content 'Errored out n00b'
      end
    end
  end
end
