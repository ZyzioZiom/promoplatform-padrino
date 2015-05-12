class RenameAccountIdInActions < ActiveRecord::Migration
  def self.up
    rename_column :actions, :account_id, :user_id
  end

  def self.down
  end
end
