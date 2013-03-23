class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :votable, :polymorphic => true
      t.belongs_to :user
      t.string :direction

      t.timestamps
    end

    add_index :votes, [:votable_id, :votable_type, :user_id], :unique => true
  end
end
