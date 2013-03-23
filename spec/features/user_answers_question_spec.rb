require 'spec_helper'

describe "User answers question" do
  fixtures :users, :questions
  let(:user) { users(:tester) }
  let(:question) { questions(:test) }

  describe "answering question" do

    before(:each) do
      sign_in_as user
      visit question_path(question)
    end

    context "valid inputs" do
      before do
        within 'form#new_answer' do
          fill_in 'answer[content]', :with => 'Test answer'
          click_button 'Submit Answer'
        end
      end

      it "should be on the question page" do
        current_path.should eq question_path(question)
      end

      it "should show the new answer on the page" do
        within "#answers" do
          page.should have_content 'Test answer'
        end
      end
    end

    context "invalid inputs" do
      before do
        within "form#new_answer" do
          click_button "Submit Answer"
        end
      end

      it "should highlight incorrect fields" do
        within "form#new_answer" do
          page.should have_selector '.control-group.error'
        end
      end

      it "should show an error message" do
        within "form#new_answer" do
          page.should have_content "can't be blank"
        end
      end
    end
  end
end
