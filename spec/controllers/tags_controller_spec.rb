require 'spec_helper'

describe TagsController do

  fixtures :tags, :questions, :users

  let(:tag) { tags(:test) }
  let(:user) { users(:tester) }
  let(:many_tags) { [tags(:test), tags(:test2), tags(:test3)] }

  it "should require sign-in" do
    get :index
    response.should redirect_to new_user_session_path
  end

  describe "GET 'index'" do
    before do
      sign_in user
      Tag.stub(:all).and_return(many_tags)
      get :index
    end

    it "should assign a list of tags" do
      assigns(:tags).should have(3).tags
    end

    it "should render the index template" do
      response.should render_template :index
    end
  end

  describe "GET 'show'" do
    before do
      sign_in user
      get :show, :id => tag.id
    end

    it "should assign the tag" do
      assigns(:tag).should eq tag
    end

    it "should render the show template" do
      response.should render_template :show
    end

    context "current tag has no questions" do
      before do
        tag.questions.clear
        get :show, :id => tag.id
      end

      it "should redirect to the tags page" do
        response.should redirect_to Tag
      end

      it "should set an alert for the user" do
        flash[:notice].should_not be_blank
      end
    end
  end
end
