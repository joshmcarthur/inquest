class Users::NotificationRulesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notification_rules = current_user.notification_rules
    @notification_rule = NotificationRule.new
  end

  def create
    @notification_rule = current_user.notification_rules.build(notification_rule_params)
    respond_with @notification_rule, location: user_notification_rules_path
  end

  def destroy
    @notification_rule = current_user.notification_rules.destroy(params[:id])
    respond_with @notification_rule
  end

  private

  def notification_rule_params
    params.require(:notification_rule).permit(:class_name, :reactor_name, :action)
  end

end
