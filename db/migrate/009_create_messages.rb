class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :who
      t.string :content
      t.integer :what
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
