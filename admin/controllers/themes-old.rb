PromoplatformPadrino::Admin.controllers :themes do
  @@loger = Logger.new("log/themes.log")
  
  get :index do
    render 'themes/index'
  end
  
  get :new do
    render 'themes/new'
  end
  
  get :edit do
    if $theme == "default"
      flash[:error] = "Nie możesz edytować domyślnego mooda. Skopiuj go i pracuj na kopii"
      
      redirect_to(url(:themes, :index))
    end    
        
    current_theme = File.open "public/stylesheets/#{$theme}.css", "r"
    @css = ""
    
    current_theme.each do |line|
      @css << line
    end
    
    
    
    render 'themes/edit'
  end
  
  post :create do
  end
  
  post :update do
    begin
      @content = params[:css_content]
      File.open "public/stylesheets/#{$theme}.css", "w" do |f|
        f.write(@content)
      end

      flash[:success] = "Aktualizacja pomyślna"
      redirect(url(:themes, :edit))

    rescue => e
      flash[:error] = "Wystąpił błąd - aktualizacja zakończyła się niepowodzeniem."
      @@logger.fatal "Error updating theme: #{e.class} - #{e.message}"
      redirect back
    end
  end
  
  post :change_theme do
  
    $theme = params[:theme]
    
    File.open "lib/theme.rb", "w" do |f|
      f.write("$theme = '#{params[:theme]}'")
    end
    flash[:success] = "Zmieniono mood: #{params[:theme]}"

    redirect(url(:themes, :index))
  end
  
end