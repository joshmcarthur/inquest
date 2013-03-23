class AddAcceptedToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :accepted, :boolean, :default => false, :null => false
  end
end
