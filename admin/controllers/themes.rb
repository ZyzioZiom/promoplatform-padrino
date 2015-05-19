PromoplatformPadrino::Admin.controllers :themes do
  get :index do
    @title = "Themes"
    @themes = Theme.all
    render 'themes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'theme')
    @theme = Theme.new
    render 'themes/new'
  end

  post :create do
    @theme = Theme.new(params[:theme])
    if @theme.save
      @title = pat(:create_title, :model => "theme #{@theme.id}")
      
      unless Dir.exist?("public/images/#{@theme.name}")
        Dir.mkdir("public/images/#{@theme.name}")
      end
      
      
      
      
      flash[:success] = pat(:create_success, :model => 'Theme')
      
      
      
      params[:save_and_continue] ? redirect(url(:themes, :index)) : redirect(url(:themes, :edit, :id => @theme.id))
    else
      @title = pat(:create_title, :model => 'theme')
      flash.now[:error] = pat(:create_error, :model => 'theme')
      render 'themes/new'
    end
    
    
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "theme #{params[:id]}")
    @theme = Theme.find(params[:id])
    if @theme.name == "default"
      flash[:error] = "Nie możesz edytować domyślnego mooda. Skopiuj go i pracuj na kopii"
      redirect back
    end
  
    if @theme
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
      if @theme.update_attributes(params[:theme])
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

  
end
