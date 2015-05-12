class ChangeUserNameAndSurname < ActiveRecord::Migration
  def self.up
    rename_column :users, :name, :firstname
    rename_column :users, :surname, :lastname
  end

  def self.down
  end
end
