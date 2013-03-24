require 'spec_helper'

describe 'User invites a new user' do
  fixtures :users

  let(:user) { users(:tester) }

  describe 'sending invitation' do
    before do
      sign_in_as user
      visit new_user_invitation_path
    end

    it "should show a form" do
      page.should have_selector "form#new_user[action='/users/invitation']"
    end

    it "should show an email address field" do
      page.should have_field "Email"
    end

    context "valid email address filled in" do
      before do
        visit new_user_invitation_path
        within "form#new_user" do
          fill_in "Email", :with => "newuser@example.com"
          click_button "Send an invitation"
        end
      end

      it "should be back on the root page" do
        current_path.should eq root_path
      end

      it "should show a success message" do
        page.should have_selector ".alert.alert"
      end
    end

    context "invalid email address filled in" do
      before do
        visit new_user_invitation_path
        within "form#new_user" do
          fill_in "Email", :with => user.email
          click_button "Send an invitation"
        end
      end

      it "should show an error message" do
        page.should have_content 'has already been taken'
      end
    end
  end
end