require 'spec_helper'

describe QuestionsController do
  fixtures :users
  fixtures :questions

  let(:question) { questions(:test) }
  context "when I am not logged in" do
    it "should require an authenticated user" do
      get :index 
      response.should redirect_to new_user_session_path
      flash[:alert].should_not be_blank
    end
  end

  context "when I am logged in" do
    before do
      sign_in users(:tester)
    end

    describe "GET index" do
      before do
        Question.stub(:page).and_return([Question.new, Question.new])
        get :index
      end

      it "should render the index template" do
        response.should render_template :index
      end

      it "should instantiate a collection of questions" do
        assigns(:questions).should have(2).instances_of(Question)
      end

      it "should paginate" do
        Question.should_receive(:page)
        get :index
      end

      it "should search" do
        Question.should_receive(:search).and_call_original
        get :index
      end

      it "should perform a valid search" do
        Question.unstub(:page)
        get :index, :q => {:title_or_content_cont => question.title }
        assigns(:questions).should eq [question]
      end
    end

    describe "POST create" do
      context "correct attributes are provided" do
        before do
          post :create, :question => {:title => 'New Question', :content => 'New Content'}
        end

        it "should redirect to the question page" do
          response.should redirect_to assigns(:question)
        end

        it "should save the question" do
          assigns(:question).should be_persisted
        end

        it "should assign the created question" do
          assigns(:question).should be_a(Question)
        end
      end

      context "incorrect attributes are provied" do
        before do
          post :create, :question => {:title => ''}
        end

        it "should assign the question" do
          assigns(:question).should be_a(Question)
        end

        it "should not save the question" do
          assigns(:question).should_not be_persisted
        end

        it "should render the new template" do
          response.should render_template :new
        end
      end
    end
  end
end
