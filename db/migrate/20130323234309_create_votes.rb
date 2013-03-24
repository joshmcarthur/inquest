class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :voteable, :polymorphic => true
      t.belongs_to :user
      t.string :direction

      t.timestamps
    end

    add_index :votes, [:voteable_id, :voteable_type, :user_id], :unique => true
  end
end
