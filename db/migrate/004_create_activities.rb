class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :type
      t.time :hour
      t.string :day
      t.date :date
      t.string :place
      t.string :name
      t.text :description
      t.integer :points
      t.string :image
      t.boolean :global_talents
      t.boolean :global_citizen
      t.boolean :career_days
      t.boolean :career_forum
      t.boolean :future_leaders
      t.boolean :aiesec_university
      t.boolean :youth_to_business_forum
      t.boolean :global_host
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
