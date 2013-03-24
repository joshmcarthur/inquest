module CapybaraHelpers
  def sign_in_as(user)
    visit new_user_session_path

    within "form#new_user" do
      fill_in "user[login]", :with => user.username
      fill_in "user[password]", :with => 'password1'
    end

    click_button "Log In"
  end

  def fill_in_question
    within 'form#new_question' do
      fill_in 'question[title]', :with => 'How do I use?'
      fill_in 'question[content]', :with => 'I would really like to use Inquest, how do I use it?'
      yield #fill_in 'question[tags_string]', :with => 'tags1'
      #click_button 'Create Question'
    end
  end

  def open_page!
    save_and_open_page
  end
end
