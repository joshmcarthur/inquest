class AlterTagName < ActiveRecord::Migration
  def up
    change_column :tags, :name, :string, null: false, unique: true
  end

  def down
    change_column :tags, :name, :string, null: true
  end
end
