module CapybaraHelpers
  def sign_in_as(user)
    visit new_user_session_path

    within "form#new_user" do
      fill_in "user[login]", :with => user.username
      fill_in "user[password]", :with => 'password1'
    end

    click_button "Log In"
  end
end
