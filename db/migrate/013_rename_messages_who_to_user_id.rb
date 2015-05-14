class RenameMessagesWhoToUserId < ActiveRecord::Migration
  def self.up
    rename_column :messages, :who, :user_id
  end

  def self.down
  end
end
