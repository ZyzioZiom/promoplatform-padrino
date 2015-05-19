class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :name
      t.string :welcome_heading
      t.text :welcome_message
      t.string :activity_confirmed
      t.string :chat_title
      t.string :send_message_button
      t.string :action_confirmed
      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
