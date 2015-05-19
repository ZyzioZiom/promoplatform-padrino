class Theme < ActiveRecord::Base
  validates :name, uniqueness: true
  validates_presence_of :name, :welcome_heading, :activity_confirmed, :chat_title, :send_message_button, :action_confirmed
  
  def self.name
    $theme
  end
  
  def self.welcome_heading
    Theme.where(name: $theme).first.welcome_heading
  end
  
  def self.welcome_message
    Theme.where(name: $theme).first.welcome_message
  end
  
  def self.activity_confirmed
    Theme.where(name: $theme).first.activity_confirmed
  end
    
  def self.chat_title
    Theme.where(name: $theme).first.chat_title
  end
    
  def self.send_message_button
    Theme.where(name: $theme).first.send_message_button
  end
    
  def self.action_confirmed
    Theme.where(name: $theme).first.action_confirmed
  end
  
  def self.list
    themes = []
    Theme.all.each do |theme|
      themes.push(theme.name)
    end
    
    themes
  end
    
end
