class CreateNotificationRules < ActiveRecord::Migration
  def change
    create_table :notification_rules do |t|
      t.belongs_to :user
      t.string :class_name
      t.string :reactor_name
      t.string :action

      t.timestamps
    end
    add_index :notification_rules, :user_id
  end
end
