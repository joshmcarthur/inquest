require 'spec_helper'

describe "User tag question" do
  fixtures :users, :questions, :tags

  let(:user) { users(:tester) }
  let(:tag) { tags(:test) }
  let(:tag2) { tags(:test2) }
  let(:tag3) { tags(:test3) }
  let(:tag4) { tags(:test4) }
  let(:tag5) { tags(:test5) }



  describe "tag question" do

    before(:each) do
      sign_in_as user
      visit new_question_path
    end

    context "valid inputs" do
      describe "1 to 5 tags" do

        context "1 existing tag" do

          before do
            fill_in_question { fill_in 'question[tags_string]', :with => 'tagtest' }
          end

          it "should show the new tags beside the question." do
            within ".tags" do
              page.should have_content 'tagtest'
            end
          end

        end

        context "5 existing tags" do
          before do
            fill_in_question { fill_in 'question[tags_string]', :with => 'tagtest, tagtest2, tagtest3, tagtest4, tagtest5' }
          end

          it "should show the new tags beside the question." do
            within ".tags" do
              page.should have_content 'tagtest'
            end
          end

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