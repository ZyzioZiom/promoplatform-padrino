class RenameAccountsToUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    rename_table :accounts, :users
  end

  def self.down
  end
end
