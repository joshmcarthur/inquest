require 'spec_helper'

describe "Notifications" do
  fixtures :users

  let(:user) { users(:tester) }

  describe "when user creates questions" do
    before do
      create_notification_rule("Question", "create")
    end

    it "should create a notification" do
      Disclosure::Rule.any_instance.should_receive(:react!).with(an_instance_of(Question)).once()
      user.questions.create(:title => "Test", :content => "Test")
    end

    describe "notification" do
      before do
        user.questions.create(:title => "Test", :content => "Test")
      end

      subject do
        ActionMailer::Base.deliveries.last
      end

      it "should be sent to me" do
        subject.to.should eq [user.email]
      end

      it "should describe what happened" do
        subject.body.should include "#{user.questions.last.title} has been created"
      end

      it "should contain a link to the question" do
        subject.body.should include "/questions/#{user.questions.last.id}"
      end
    end
  end

  describe "when user answers question" do
    before do
      create_notification_rule("Answer", "accepted")
    end

    it "should create a notification" do
      question = user.questions.create(:title => "Test", :content => "Test")
      answer = question.answers.create(:user => user, :content => "Test")
      Disclosure::Rule.any_instance.should_receive(:react!).with(an_instance_of(Answer)).once()
      answer.accept!
    end

    describe "notification" do
      before do
        question = user.questions.create(:title => "Test", :content => "Test")
        answer = question.answers.create(:user => user, :content => "Test").accept!
      end

      subject do
        ActionMailer::Base.deliveries.last
      end

      it "should be sent to me" do
        subject.to.should eq [user.email]
      end

      it "should describe what happened" do
        subject.body.should include "#{user.questions.last.title} has been marked with an accepted answer."
      end

      it "should contain a link to the question" do
        subject.body.should include  "/questions/#{user.questions.last.id}"
      end
    end
  end

  describe "when user votes question" do
    before do
      create_notification_rule("Vote", "create")
    end

    it "should create a notification" do
      question = user.questions.create(:title => "Test", :content => "Test")
      Disclosure::Rule.any_instance.should_receive(:react!).with(an_instance_of(Vote)).once()
      question.votes.create(:user => user, :direction => 'up')
    end

    describe "notification" do
      before do
        question = user.questions.create(:title => "Test", :content => "Test")
        question.votes.create(:user => user, :direction => 'up')
      end

      subject do
        ActionMailer::Base.deliveries.last
      end

      it "should be sent to me" do
        subject.to.should eq [user.email]
      end

      it "should describe what happened" do
        subject.body.should include "#{user.questions.last.title} was upvoted"
      end

      it "should contain a link to the question" do
        subject.body.should include  "/questions/#{user.questions.last.id}"
      end
    end
  end

  describe "when user votes answer" do
    before do
      create_notification_rule("Vote", "create")
    end

    it "should create a notification" do
      question = user.questions.create(:title => "Test", :content => "Test")
      answer = question.answers.create(:content => "Test", :user => user)
      Disclosure::Rule.any_instance.should_receive(:react!).with(an_instance_of(Vote)).once()
      answer.votes.create(:user => user, :direction => 'down')
    end

    describe "notification" do
      before do
        question = user.questions.create(:title => "Test", :content => "Test")
        answer = question.answers.create(:content => "Test", :user => user)
        answer.votes.create(:user => user, :direction => 'down')
      end

      subject do
        ActionMailer::Base.deliveries.last
      end

      it "should be sent to me" do
        subject.to.should eq [user.email]
      end

      it "should describe what happened" do
        subject.body.should include "#{user.questions.last.title} was downvoted"
      end

      it "should contain a link to the question" do
        subject.body.should include  "/questions/#{user.questions.last.id}"
      end
    end
  end

  describe "when user comments on question" do
    before do
      create_notification_rule("Comment", "create")
    end

    it "should create a notification" do
      question = user.questions.create(:title => "Test", :content => "Test")
      Disclosure::Rule.any_instance.should_receive(:react!).with(an_instance_of(Comment)).once()
      question.comments.create(:user => user, :content => 'Test')
    end

    describe "notification" do
      before do
        question = user.questions.create(:title => "Test", :content => "Test")
        question.comments.create(:user => user, :content => 'Test')
      end

      subject do
        ActionMailer::Base.deliveries.last
      end

      it "should be sent to me" do
        subject.to.should eq [user.email]
      end

      it "should describe what happened" do
        subject.body.should include "A comment has just been added to #{user.questions.last.title}"
      end

      it "should contain a link to the question" do
        subject.body.should include  "/questions/#{user.questions.last.id}"
      end
    end
  end

  def create_notification_rule(model, action)
    user.notification_rules.where(
      :notifier_class => model,
      :action => action,
      :reactor_class => "Disclosure::EmailReactor"
    ).first_or_create
  end
end
