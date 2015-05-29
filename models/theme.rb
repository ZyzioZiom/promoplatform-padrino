class Theme < ActiveRecord::Base
  @@logger = Logger.new "log/theme.log"
  
  validates :name, uniqueness: true
  validates_presence_of :name, :welcome_heading, :activity_confirmed, :chat_title, :send_message_button, :action_confirmed
  
  
  def self.list
    themes = []
    Theme.all.each do |theme|
      themes.push(theme.name)
    end
    
    themes
  rescue => e
    logger.fatal "Error listing themes: #{e.class} - #{e.message}"
  end
  
  def self.current
    Theme.where(name: $theme).first
  rescue => e
    logger.fatal "Error getting current theme: #{e.class} - #{e.message}"
  end
  
  def variables
    Theme.where(name: name).first
  rescue => e
    logger.fatal "Error getting theme variables: #{e.class} - #{e.message}"
  end
  
  def rename_files(name, new_name)
    new_name = Utility.sanitize(new_name)
    
    FileUtils.mv "public/themes/#{name}", "public/themes/#{new_name}"
    FileUtils.mv "public/stylesheets/#{name}.css", "public/stylesheets/#{new_name}.css"
    
    css = File.read("public/stylesheets/#{new_name}.css")
    css.gsub!("background: url\(\.\.\/themes\/#{name}","background: url(../themes/#{new_name}")

    File.open "public/stylesheets/#{new_name}.css", "w" do |f|
      f.write(css)
    end
  rescue => e
    logger.fatal "Error renaming theme files: #{e.class} - #{e.message}"
  end
  
  def delete(name)
    FileUtils.rm_r "public/themes/#{name}"
    FileUtils.rm_r "public/stylesheets/#{name}.css"
    
  rescue => e
    @@logger.fatal "Error deleting theme files: #{e.class} - #{e.message}"
  end
  
  def create(name)
    Theme.create_theme_directory(name)
    Theme.create_images(name)
    Theme.create_css(name)
  rescue => e
    logger.fatal "Error creating theme files: #{e.class} - #{e.message}"
  end
  
  def self.create_theme_directory(name)
    unless Dir.exist?("public/themes/#{name}")
      Dir.mkdir("public/themes/#{name}")
    end
  rescue => e
    logger.fatal "Error creating theme directory: #{e.class} - #{e.message}"
  end
  
  def self.create_images(name)
    FileUtils.cp "public/themes/default/login-background.jpg", "public/themes/#{name}/login-background.jpg"
    FileUtils.cp "public/themes/default/home-background.jpg", "public/themes/#{name}/home-background.jpg"
    FileUtils.cp "public/themes/default/login-button.png", "public/themes/#{name}/login-button.png"
  rescue => e
    logger.fatal "Error creating theme images: #{e.class} - #{e.message}"
  end
  
  def self.create_css(theme_name)
    default_css = "public/stylesheets/default.css"
    new_css = "public/stylesheets/#{theme_name}.css"

    FileUtils.cp default_css, new_css
    
    # replace "default" to new theme name in css content
    css = File.read(new_css).gsub("default",theme_name)

    File.open new_css, "w" do |f|
      f.write(css)
    end
  rescue => e
    logger.fatal "Error creating theme css: #{e.class} - #{e.message}"
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
  rescue => e
    logger.fatal "Error updating theme images: #{e.class} - #{e.message}"
  end
end
