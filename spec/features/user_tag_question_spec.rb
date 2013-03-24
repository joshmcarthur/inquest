require 'spec_helper'

describe "User tag question" do
  fixtures :users, :questions, :tags

  let(:user) { users(:tester) }
  let(:tag) { tags(:test) }

  describe "tag question" do

    before(:each) do
      sign_in_as user
      visit new_question_path
    end

    context "valid inputs" do
      describe "1 to 5 tags" do

        context "1 existing tag" do

          before do
            fill_in_question do
              fill_in 'question[tags_string]', :with => "#{tag['title']}"
              click_button 'Create Question'
            end
          end

          it "should show the new tags beside the question." do
            within ".tags" do
              page.should have_content "#{tag['title']}"
            end
          end

        end

        context "5 existing tags" do
        end
      end
    end

    context "invalid inputs" do

      describe "one or more non-existing tags" do
        context "1 non-existing tag" do
        end

        context "1 existing tags and 1 non-existing tag" do
        end
      end

      describe "more than 5 existing tags" do
        context "6 existing tags" do
        end

        context "10 existing tags" do
        end
      end

      describe "duplicated tag" do

        context "duplicated tags with case " do
        end

        context "duplicated tags with different case" do
        end

      end

    end

  end
end