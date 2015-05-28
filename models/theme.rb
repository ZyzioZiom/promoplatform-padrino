class Theme < ActiveRecord::Base
  @@logger = Logger.new("log/theme.log")
  validates :name, uniqueness: true
  validates_presence_of :name, :welcome_heading, :activity_confirmed, :chat_title, :send_message_button, :action_confirmed

  def self.variables
    Theme.where(name: $theme).take
  end
  
  
  def self.list
    themes = []
    Theme.all.each do |theme|
      themes.push(theme.name)
    end
    
    themes
  end
    
  def self.rename(old_name, new_name)
    new_name = Utility.sanitize(new_name)
    
    FileUtils.mv "public/themes/#{old_name}", "public/themes/#{new_name}"
    FileUtils.mv "public/stylesheets/#{old_name}.css", "public/stylesheets/#{new_name}.css"
    
    
    css = File.read("public/stylesheets/#{new_name}.css")
    
    css.gsub!("background: url\(\.\.\/themes\/#{old_name}","background: url(../themes/#{new_name}")

    File.open "public/stylesheets/#{new_name}.css", "w" do |f|
      f.write(css)
    end
  end
  
  def self.delete(name)
    FileUtils.rm_r "public/themes/#{name}"
    FileUtils.rm_r "public/stylesheets/#{name}.css"
  rescue => e
    @@logger.fatal "Error deleting theme: #{e.class} - #{e.message}"
  end
  
  def self.create_theme_directory(theme_name)
    unless Dir.exist?("public/themes/#{theme_name}")
      Dir.mkdir("public/themes/#{theme_name}")
    end
  end
  
  def self.create_images(theme_name)
    FileUtils.cp "public/themes/default/login-background.jpg", "public/themes/#{theme_name}/login-background.jpg"
    FileUtils.cp "public/themes/default/home-background.jpg", "public/themes/#{theme_name}/home-background.jpg"
    FileUtils.cp "public/themes/default/login-button.png", "public/themes/#{theme_name}/login-button.png"
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
  
  def self.update_images(args)
    theme_name = args[:theme_name]
    login_background = args[:login_background]
    home_background = args[:home_background]
    login_button = args[:login_button]
    
    [
      [login_background, "login-background.jpg"],
      [home_background, "home-background.jpg"],
      [login_button, "login-button.png"]
    ].each do |file|
      if file[0]
        unless file[0][:type].include? "image"
          return { :error => "Możesz wysyłać tylko obrazki" }
        end
        
        f = File.new "public/themes/#{theme_name}/#{file[1]}", "w+b"
        f.write file[0][:tempfile].read
        f.close
      end
    end
    { :success => "Nowe obrazki zostały wgrane od mooda" }
  end
end
