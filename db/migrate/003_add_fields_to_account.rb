class AddFieldsToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :uid, :string
    add_column :accounts, :image, :string
    
  end

  def self.down
  end
end
