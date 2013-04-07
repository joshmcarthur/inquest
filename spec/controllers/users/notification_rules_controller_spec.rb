require 'spec_helper'

describe Users::NotificationRulesController do
  fixtures :users 

  let(:valid_attributes) do
    {
      :rule => {
        :notifier_class => "Question", 
        :action => "create", 
        :reactor_class => "Disclosure::EmailReactor"
      }
    }
  end

  before do
    sign_in users(:tester)
  end

  describe "GET index" do
    before do
      get :index
    end

    it "should assign a new notification rule" do
      assigns(:notification_rule).should be_a_new(Disclosure::Rule)
    end

    it "should render the index template" do
      response.should render_template :index
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      before do
        post :create, valid_attributes
      end

      it "should have saved a record" do
        assigns(:notification_rule).should be_persisted
      end

      it "should set a success message" do
        flash[:notice].should_not be_blank
      end

      it "should redirect to the index action" do
        response.should redirect_to users_notification_rules_path
      end
    end

    context "with invalid attributes" do
      before do
        post :create, {:rule => {:notifier_class => "Question"}}
      end

      it "should assign the built record" do
        assigns(:notification_rule).should be_a(Disclosure::Rule)
      end

      it "should render the index action" do
        response.should render_template :index
      end
    end
  end
end
