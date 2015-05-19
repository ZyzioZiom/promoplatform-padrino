class Theme < ActiveRecord::Base
  @@logger = Logger.new("log/theme.log")
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
    
  def self.rename(old_name, new_name)
    FileUtils.mv "public/images/#{old_name}", "public/images/#{new_name}"
    FileUtils.mv "public/stylesheets/#{old_name}.css", "public/stylesheets/#{new_name}.css"
  end
  
  def self.delete(name)
    FileUtils.remove_dir "public/images/#{name}"
    FileUtils.remove_dir "public/stylesheets/#{name}.css"
  rescue => e
    @@logger.fatal "Error deleting theme: #{e.class} - #{e.message}"
  end
  
  def self.create_images_directory(theme_name)
    unless Dir.exist?("public/images/#{theme_name}")
      Dir.mkdir("public/images/#{theme_name}")
    end
  end
  
  def self.create_images(theme_name)
    FileUtils.cp "public/images/default/login-background.jpg", "public/images/#{theme_name}/login-background.jpg"
    FileUtils.cp "public/images/default/home-background.jpg", "public/images/#{theme_name}/home-background.jpg"
  end
  
  def self.create_css(theme_name)
    default_css = "public/stylesheets/default.css"
    new_css = "public/stylesheets/#{theme_name}.css"

    FileUtils.cp default_css, new_css

    css = File.read(new_css).gsub("default",theme_name)

    File.open new_css, "w" do |f|
      f.write(css)
    end
  end
end
