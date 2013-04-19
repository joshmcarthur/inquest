require 'spec_helper'

describe "User creates question" do
  fixtures :users, :questions, :tags
  let(:user) { users(:tester) }
  let(:question) { questions(:test) }

  describe "creating question" do

    before(:each) do
      tags
      sign_in_as user
      click_link 'New Question'
    end

    context "with invalid inputs" do
      before do
        within "form#new_question" do
          click_button 'Create Question'
        end
      end

      it "should be on the new question page" do
        page.should have_selector "form#new_question"
      end

      it "should show an error message on each required input" do
        all('.control-group.error').should have(4).items
      end
    end

    context "with valid inputs" do
      before do
        within "form#new_question" do
          fill_in "Title", :with => question.title
          select tags(:test).name, :from => 'question[tag_ids][]'
          fill_in 'Content', :with => question.content
          click_button 'Create Question'
        end
      end

      it "should still have the new question form" do
        current_path.should match question_path(Question.last.id)
      end

      it "should show the title" do
        page.should have_content question.title
      end

      it "should show tags" do
        all('.tags-display > a.tag').should have(1).item
      end

      it "should show content" do
        page.should have_content question.content
      end

      it "should show the owner controls" do
        page.should have_selector "#owner_controls"
      end
    end
  end
end