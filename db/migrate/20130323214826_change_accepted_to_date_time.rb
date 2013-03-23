class ChangeAcceptedToDateTime < ActiveRecord::Migration
  def up
    remove_column :answers, :accepted
    add_column :answers, :accepted_at, :datetime
  end

  def down
    remove_column :answers, :accepted_at
    add_column :answers, :accepted, :boolean, :default => false
  end
end
