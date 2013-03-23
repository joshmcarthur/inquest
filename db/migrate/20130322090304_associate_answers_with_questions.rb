class AssociateAnswersWithQuestions < ActiveRecord::Migration
  def up
    change_table :answers do |t|
      t.references :question, :null => false
    end

    add_index :answers, :question_id
  end

  def down
    remove_index :answers, :question_id
    remove_column :answers, :question_id
  end
end
