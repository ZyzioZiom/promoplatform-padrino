PromoplatformPadrino::Admin.controllers :levels do
  get :index do
    @title = "Levels"
    @levels = Level.order(:points)
    @images = Dir["public/levels/*"]
    render 'levels/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'level')
    @level = Level.new
    @images = Dir["public/levels/*"]
    render 'levels/new'
  end

  post :create do
    @level = Level.new(params[:level])
    @images = Dir["public/levels/*"]
    if @level.save
      @title = pat(:create_title, :model => "level #{@level.id}")
      flash[:success] = pat(:create_success, :model => 'Level')
      params[:save_and_continue] ? redirect(url(:levels, :index)) : redirect(url(:levels, :edit, :id => @level.id))
    else
      @title = pat(:create_title, :model => 'level')
      flash.now[:error] = pat(:create_error, :model => 'level')
      render 'levels/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "level #{params[:id]}")
    @level = Level.find(params[:id])
    @images = Dir["public/levels/*"]
    if @level
      render 'levels/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'level', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "level #{params[:id]}")
    @level = Level.find(params[:id])
    if @level
      if @level.update_attributes(params[:level])
        flash[:success] = pat(:update_success, :model => 'Level', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:levels, :index)) :
          redirect(url(:levels, :edit, :id => @level.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'level')
        render 'levels/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'level', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Levels"
    level = Level.find(params[:id])
    if level
      if level.destroy
        flash[:success] = pat(:delete_success, :model => 'Level', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'level')
      end
      redirect url(:levels, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'level', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Levels"
    unless params[:level_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'level')
      redirect(url(:levels, :index))
    end
    ids = params[:level_ids].split(',').map(&:strip)
    levels = Level.find(ids)
    
    if Level.destroy levels
    
      flash[:success] = pat(:destroy_many_success, :model => 'Levels', :ids => "#{ids.to_sentence}")
    end
    redirect url(:levels, :index)
  end


  post :upload_level_image do
    level_image = params[:level_image]
    
    if level_image
      unless level_image[:type].include? "image"
        flash[:error] = "Możesz wysyłać tylko obrazki"
        redirect back
      end
      
      f = File.new "public/levels/#{level_image[:filename]}", "w+b"
      f.write level_image[:tempfile].read
      f.close
    end
    
    
    
    flash[:success] = "Nowy obrazek został wgrany do platformy"
    redirect back
  end
end
