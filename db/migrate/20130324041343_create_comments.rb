class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, :polymorphic => true
      t.belongs_to :user
      t.text :content

      t.timestamps
    end

    add_index :comments, [:commentable_id, :user_id]
  end
end
