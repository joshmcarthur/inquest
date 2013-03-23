class AssociateUsersWithQuestionsAndAnswers < ActiveRecord::Migration
  def up
    change_table :answers do |t|
      t.references :user, :null => false
    end

    change_table :questions do |t|
      t.references :user, :null => false
    end

    add_index :answers, :user_id
    add_index :questions, :user_id
  end

  def down
    remove_index :answers, :user_id
    remove_index :answers, :user_id

    remove_column :answers, :user_id
    remove_column :questions, :user_id
  end
end
