class AddCounterCacheToVoteables < ActiveRecord::Migration
  def change
    add_column :questions, :votes_count, :integer, :default => 0, :null => false
    add_column :answers, :votes_count, :integer, :default => 0, :null => false
  end
end
