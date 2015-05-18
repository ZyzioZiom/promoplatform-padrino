class RenameMessageWhatToActivityId < ActiveRecord::Migration
  def self.up
    rename_column :messages, :what, :activity_id
  end

  def self.down
  end
end
