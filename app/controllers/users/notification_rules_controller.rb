class Users::NotificationRulesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notification_rule = NotificationRule.new
  end

  def create
    @notification_rule = current_user.notification_rules.build(notification_rule_params)

    if @notification_rule.save
      redirect_to users_notification_rules_path, notice: 'Notification has been set up.'
    else
      render :index
    end
  end

  def destroy
    @notification_rule = current_user.notification_rules.destroy(params[:id])
    redirect_to users_notification_rules_path, notice: 'You will no longer receive notifications matching this criteria.'
  end

  private

  def notification_rule_params
    params.require(:notification_rule).permit(:class_name, :reactor_name, :action)
  end

end
