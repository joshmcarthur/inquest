require 'spec_helper'

describe "User tag question" do
  fixtures :users, :questions, :tags
  let(:user) { users(:tester) }
  let(:question) { questions(:test) }
  let(:tag1) { tags(:tag1) }

  describe "tag question" do

    before(:each) do
      sign_in_as user
      visit question_path(question)
    end

    context "valid inputs" do
      describe "1 to 5 tags" do

        context "1 existing tag" do

          before do
            within 'form#new_answer' do
              fill_in 'answer[content]', :with => 'Test answer'
              fill_in 'answer[tags_string]', :with => 'tag1'
              click_button 'Submit Answer'
            end
          end

          it "should be on the question page" do
            current_path.should eq question_path(question)
          end

          it "should show the new tags beside the question." do

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