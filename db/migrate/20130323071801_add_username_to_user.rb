class AddUsernameToUser < ActiveRecord::Migration
  def up 
    add_column :users, :username, :string
    User.find_each do |user|
      user.username = user.email.split('@').first
      user.save!
    end

    change_column :users, :username, :string, :null => false, :unique => true
  end

  def down
    remove_column :users, :username
  end
end
