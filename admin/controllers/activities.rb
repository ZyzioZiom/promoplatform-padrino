require 'csv'

PromoplatformPadrino::Admin.controllers :activities do
  get :index do
    @title = "Activities"
    @activities = Activity.order(updated_at: :desc)
    render 'activities/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'activity')
    @activity = Activity.new
    render 'activities/new'
  end

  post :create do
    @activity = Activity.new(params[:activity])
    if @activity.save
      @title = pat(:create_title, :model => "activity #{@activity.id}")
      flash[:success] = pat(:create_success, :model => 'Activity')
      params[:save_and_continue] ? redirect(url(:activities, :index)) : redirect(url(:activities, :edit, :id => @activity.id))
    else
      @title = pat(:create_title, :model => 'activity')
      flash.now[:error] = pat(:create_error, :model => 'activity')
      render 'activities/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "activity #{params[:id]}")
    @activity = Activity.find(params[:id])
    if @activity
      render 'activities/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'activity', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "activity #{params[:id]}")
    @activity = Activity.find(params[:id])
    if @activity
      if @activity.update_attributes(params[:activity])
        flash[:success] = pat(:update_success, :model => 'Activity', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:activities, :index)) :
          redirect(url(:activities, :edit, :id => @activity.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'activity')
        render 'activities/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'activity', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Activities"
    activity = Activity.find(params[:id])
    if activity
      if activity.destroy
        flash[:success] = pat(:delete_success, :model => 'Activity', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'activity')
      end
      redirect url(:activities, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'activity', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Activities"
    unless params[:activity_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'activity')
      redirect(url(:activities, :index))
    end
    ids = params[:activity_ids].split(',').map(&:strip)
    activities = Activity.find(ids)
    
    if Activity.destroy activities
    
      flash[:success] = pat(:destroy_many_success, :model => 'Activities', :ids => "#{ids.to_sentence}")
    end
    redirect url(:activities, :index)
  end


  get :import do
    @title = "Import activities"
    render 'activities/import'
  end

  post :import do
    @data = Activity.import_csv(params[:csv][:tempfile].read)
    
    if @data[:result] == "success"
      flash[:success] = "Import zakończony"
    else
      flash[:error] = "Błąd importu: #{@data[:error].class} - #{@data[:error].message}"
    end
    
    redirect back
  end

  get :download_empty_csv do
    flash[:notice] = "Jeszcze nie gotowe"
    redirect back
  end

  get :download_example_csv do
    flash[:notice] = "Jeszcze nie gotowe"
    redirect back
  end

end
