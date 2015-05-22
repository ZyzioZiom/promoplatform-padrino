PromoplatformPadrino::Admin.controllers :themes do
  get :index do
    @title = "Themes"
    @themes = Theme.all
    
    @theme_variables = Theme.variables
    @theme_list = Theme.list
    
    render 'themes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'theme')
    @theme = Theme.new
    
    @theme_variables = Theme.variables
    render 'themes/new'
  end

  post :create do
    @theme = Theme.new(params[:theme])
    if @theme.save
      @title = pat(:create_title, :model => "theme #{@theme.id}")
      
      Theme.create_images_directory(@theme.name)
      
      Theme.create_images(@theme.name)
      
      Theme.create_css(@theme.name)
      

      flash[:success] = pat(:create_success, :model => 'Theme')
      params[:save_and_continue] ? redirect(url(:themes, :index)) : redirect(url(:themes, :edit, :id => @theme.id))
    else
      @title = pat(:create_title, :model => 'theme')
      flash.now[:error] = pat(:create_error, :model => 'theme')
      render 'themes/new'
    end
    
    
  end

  get :edit, :with => :id do
    @theme_variables = Theme.variables
    @title = pat("Edytuj mood")
    @theme = Theme.find(params[:id])
    if @theme.name == "default"
      flash[:error] = "Nie możesz edytować domyślnego mooda. Utwórz nowy"
      redirect back
    end
  
    if @theme
      current_theme = File.open "public/stylesheets/#{@theme.name}.css", "r"
      @css = ""

      current_theme.each do |line|
        @css << line
    end
  
      render 'themes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'theme', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "theme #{params[:id]}")
    @theme = Theme.find(params[:id])
    if @theme
      @name = @theme.name
      
      if @theme.update_attributes(params[:theme])
        
        if @name != @theme.name
          Theme.rename(@name, @theme.name)
          flash[:notice] = "Zmieniono nazwę mooda"
        end
        
        flash[:success] = pat(:update_success, :model => 'Theme', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:themes, :index)) :
          redirect(url(:themes, :edit, :id => @theme.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'theme')
        render 'themes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'theme', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Themes"
    theme = Theme.find(params[:id])
    
    if theme.name == "default"
      flash[:error] = "Nie możesz usunąć domyślnego mooda"
      redirect back
    end
    
    if theme
      if theme.destroy
        Theme.delete(theme.name)
        flash[:success] = pat(:delete_success, :model => 'Theme', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'theme')
      end
      redirect url(:themes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'theme', :id => "#{params[:id]}")
      halt 404
    end
  end

  post :update_css do
    @content = params[:css_content]
    File.open "public/stylesheets/#{params[:theme]}.css", "w" do |f|
      f.write(@content)
    end

    redirect back
  end
end
