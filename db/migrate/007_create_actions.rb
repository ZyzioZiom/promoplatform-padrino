class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.integer :account_id
      t.integer :activity_id
      t.boolean :confirmed
      t.string :confirmation
      t.integer :points
      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
