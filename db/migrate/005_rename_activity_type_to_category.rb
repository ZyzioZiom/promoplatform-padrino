class RenameActivityTypeToCategory < ActiveRecord::Migration
  def self.up
    rename_column :activities, :type, :category
  end

  def self.down
  end
end
