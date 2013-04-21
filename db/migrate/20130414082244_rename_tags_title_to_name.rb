class RenameTagsTitleToName < ActiveRecord::Migration
  def up
    rename_column :tags, :title, :name
  end

  def down
    rename_column :tags, :name, :title
  end
end
