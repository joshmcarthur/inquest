class AddStateToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :state, :string
    add_column :questions, :state_last_updated, :datetime
  end
end
