class AddWelcomesToTheme < ActiveRecord::Migration
  def self.up
    add_column :themes, :first_welcome, :string
    add_column :themes, :next_welcome, :string
  end

  def self.down
  end
end
