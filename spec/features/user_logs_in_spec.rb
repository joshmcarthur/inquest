require 'spec_helper'

describe "User logs in" do
  fixtures :users
  let(:user) { users(:tester) }

  describe "log in required" do
    before do
      visit root_path
    end

    it "should redirect to the sign in page" do
      current_path.should eq new_user_session_path
    end

    it "should show an alert message" do
      within '.alert' do
        page.should have_content I18n.t('devise.failure.unauthenticated')
      end
    end

    it "should show the sign in form" do
      page.should have_selector 'form#new_user'
    end
  end

  describe "logging in" do
    context "with valid credentials" do
      before do
        visit new_user_session_path
        within "form#new_user" do
          fill_in 'Email', :with => user.email
          fill_in 'Password', :with => 'password1'
          click_button 'Log In'
        end
      end

      it "should go to the main page" do
        current_path.should eq root_path
      end

      it "should display a welcome message" do
        within ".alert" do
          page.should have_content I18n.t('devise.sessions.signed_in')
        end
      end
    end

    context "with invalid credentials" do
      before do
        visit new_user_session_path
        within "form#new_user" do
          click_button 'Log In'
        end
      end

      it "should stay on the login page" do
        current_path.should eq new_user_session_path
      end

      it "should show an alert" do
        within ".alert" do
          page.should have_content I18n.t('devise.failure.not_found_in_database')
        end
      end
    end
  end
end
